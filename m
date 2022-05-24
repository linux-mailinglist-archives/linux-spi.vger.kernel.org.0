Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50953532316
	for <lists+linux-spi@lfdr.de>; Tue, 24 May 2022 08:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbiEXGZN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 May 2022 02:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiEXGZM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 May 2022 02:25:12 -0400
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [IPv6:2a02:9e0:8000::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418435DA79
        for <linux-spi@vger.kernel.org>; Mon, 23 May 2022 23:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
         message-id:subject:cc:to:from:date:from;
        bh=30FWcztEe848MsJjaHhubpA0fdQd9G5CkhR8nIIM8rY=;
        b=Na5vAGFtL3lVoUnGH51ABRGmccUbnNJOSq8TbeP3f1zB1Vu+usbSJN0Xz0+9ZtFhZCdSE+bdJZ/BD
         EH5AZGhysgFV3bkkegeQRa0DLT8kVECTJbv5b0xZE9VYtGp7VMmuFizl4RlGjR9FEJY0kuPu2hZk2I
         gKn3LA0jjQjFxeVNYPk+g6JMXYqYhOUZ0CiyTXBLy+YCm99mkaPZVdwoN2HlcS3Ckkau/09QH9Mva+
         yPKph+L1RA+uhsALmLtMNT/eyrV79SWTn2X8MCRCuTA2uKEYac/fiFywDhJff9QEoDumueZjV9U/dL
         9aRmjwgntnx2U0c2yJOIJcA5X4CtUWg==
X-MSG-ID: 412674b4-db2a-11ec-b450-0050569d3a82
Date:   Tue, 24 May 2022 08:25:06 +0200
From:   David Jander <david@protonic.nl>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] drivers: spi: spi.c: Convert statistics to per-cpu
 u64_stats_t
Message-ID: <20220524082506.0aa4fde6@erd992>
In-Reply-To: <YoukjLDGvz5kN5fp@lunn.ch>
References: <20220523142009.2218738-1-david@protonic.nl>
        <YoukjLDGvz5kN5fp@lunn.ch>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Hi Andrew,

Thanks a lot for the review.

On Mon, 23 May 2022 17:13:16 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Mon, May 23, 2022 at 04:20:09PM +0200, David Jander wrote:
> > This change gives a dramatic performance improvement in the hot path,
> > since many costly spin_lock_irqsave() calls can be avoided.  
> 
> It is normal to back up such claims with numbers. Please include your
> numbers here.

Ok, will add my measurement results here.

> > Suggested-by: Andrew Lunn <andrew@lunn.ch>
> > Signed-off-by: David Jander <david@protonic.nl>
> > ---
> >  drivers/spi/spi.c       | 95 ++++++++++++++++++++++++-----------------
> >  include/linux/spi/spi.h | 80 ++++++++++++++++++++++++----------
> >  2 files changed, 114 insertions(+), 61 deletions(-)
> > 
> > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> > index c4dd1200fe99..edc290e67b92 100644
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> > @@ -33,6 +33,7 @@
> >  #include <linux/idr.h>
> >  #include <linux/platform_data/x86/apple.h>
> >  #include <linux/ptp_clock_kernel.h>
> > +#include <linux/percpu.h>
> >  
> >  #define CREATE_TRACE_POINTS
> >  #include <trace/events/spi.h>
> > @@ -111,6 +112,25 @@ static ssize_t driver_override_show(struct device *dev,
> >  }
> >  static DEVICE_ATTR_RW(driver_override);
> >  
> > +#define spi_pcpu_stats_totalize(ret, in, field)				\
> > +do {									\
> > +	int i;								\
> > +	ret = 0;							\
> > +	for_each_possible_cpu(i) {					\
> > +		const struct spi_statistics *pcpu_stats;		\
> > +		u64 inc;						\
> > +		unsigned int start;					\
> > +		pcpu_stats = per_cpu_ptr(in, i);			\
> > +		do {							\
> > +			start = u64_stats_fetch_begin_irq(		\
> > +					&pcpu_stats->syncp);		\
> > +			inc = u64_stats_read(&pcpu_stats->field);	\
> > +		} while (u64_stats_fetch_retry_irq(			\
> > +					&pcpu_stats->syncp, start));	\
> > +		ret += inc;						\
> > +	}								\
> > +} while (0)  
> 
> Looking at this from the perspective of a network reviewer, that is a
> pretty big macro. netdev would probably not allow this. But macro
> magic does seem normal in this file.
> 
> What also makes a difference here is the API to user space. With
> netdev, it is not so much the absolute values of the counters, but the
> relationship with other counters that is interesting. So there is a
> method to get all the counters in one atomic snapshot. For that to
> work, the loop doing the addition adds up all the counters, not just
> one specific counter. So there is no need for 'field' which is the
> source of all this macro magic. But it seems like SPI only ever
> exports individual counters.

Yes, I initially started out just totalling all the members in one loop, but
after noticing they are never used together, I changed it.
Going to go with Marks comment here and leave it as is.

> >  #define SPI_STATISTICS_ATTRS(field, file)				\
> >  static ssize_t spi_controller_##field##_show(struct device *dev,	\
> >  					     struct device_attribute *attr, \
> > @@ -118,7 +138,7 @@ static ssize_t spi_controller_##field##_show(struct device *dev,	\
> >  {									\
> >  	struct spi_controller *ctlr = container_of(dev,			\
> >  					 struct spi_controller, dev);	\
> > -	return spi_statistics_##field##_show(&ctlr->statistics, buf);	\
> > +	return spi_statistics_##field##_show(ctlr->pcpu_statistics, buf); \
> >  }									\
> >  static struct device_attribute dev_attr_spi_controller_##field = {	\
> >  	.attr = { .name = file, .mode = 0444 },				\
> > @@ -129,7 +149,7 @@ static ssize_t spi_device_##field##_show(struct device *dev,		\
> >  					char *buf)			\
> >  {									\
> >  	struct spi_device *spi = to_spi_device(dev);			\
> > -	return spi_statistics_##field##_show(&spi->statistics, buf);	\
> > +	return spi_statistics_##field##_show(spi->pcpu_statistics, buf); \
> >  }									\
> >  static struct device_attribute dev_attr_spi_device_##field = {		\
> >  	.attr = { .name = file, .mode = 0444 },				\  
> 
> Not a criticism of this patch, but this is the old way to do this. It
> is better to use DEVICE_ATTR_RO(), but that is a bigger rework.

I suppose it is better to do this in a separate patch? @Mark, should I leave
it as is, or do you require a "modernization" for this first?

> > @@ -140,11 +160,10 @@ static struct device_attribute dev_attr_spi_device_##field = {		\
> >  static ssize_t spi_statistics_##name##_show(struct spi_statistics *stat, \
> >  					    char *buf)			\
> >  {									\
> > -	unsigned long flags;						\
> >  	ssize_t len;							\
> > -	spin_lock_irqsave(&stat->lock, flags);				\
> > -	len = sysfs_emit(buf, format_string "\n", stat->field);		\
> > -	spin_unlock_irqrestore(&stat->lock, flags);			\
> > +	u64 val;							\
> > +	spi_pcpu_stats_totalize(val, stat, field);			\
> > +	len = sysfs_emit(buf, format_string "\n", val);			\  
> 
> If you have made all the statistics u64, you don't need format_string.

Ack. Good point. I wasn't convinced to leave it all u64 till the end, so I
didn't think of removing the format strings. Will fix that.

> > @@ -543,7 +562,7 @@ struct spi_device *spi_alloc_device(struct spi_controller *ctlr)
> >  	spi->dev.release = spidev_release;
> >  	spi->mode = ctlr->buswidth_override_bits;
> >  
> > -	spin_lock_init(&spi->statistics.lock);
> > +	spi->pcpu_statistics = spi_alloc_pcpu_stats(struct spi_statistics);  
> 
> It looks like you are missing error checking here.

Oops. Will fix that.

> > @@ -3042,7 +3061,7 @@ int spi_register_controller(struct spi_controller *ctlr)
> >  		}
> >  	}
> >  	/* add statistics */
> > -	spin_lock_init(&ctlr->statistics.lock);
> > +	ctlr->pcpu_statistics = devm_spi_alloc_pcpu_stats(dev, struct spi_statistics);  
> 
> This could fail, so you should check for NULL pointer.

Thanks. Will fix.

> > +#define devm_spi_alloc_pcpu_stats(dev, type)				\
> > +({									\
> > +	typeof(type) __percpu *pcpu_stats = devm_alloc_percpu(dev, type);\
> > +	if (pcpu_stats) {						\
> > +		int __cpu;						\
> > +		for_each_possible_cpu(__cpu) {				\
> > +			typeof(type) *stat;				\
> > +			stat = per_cpu_ptr(pcpu_stats, __cpu);		\
> > +			u64_stats_init(&stat->syncp);			\
> > +		}							\
> > +	}								\
> > +	pcpu_stats;							\
> > +})
> > +
> > +#define spi_alloc_pcpu_stats(type)					\
> > +({									\
> > +	typeof(type) __percpu *pcpu_stats = alloc_percpu_gfp(type, GFP_KERNEL);\
> > +	if (pcpu_stats) {						\
> > +		int __cpu;						\
> > +		for_each_possible_cpu(__cpu) {				\
> > +			typeof(type) *stat;				\
> > +			stat = per_cpu_ptr(pcpu_stats, __cpu);		\
> > +			u64_stats_init(&stat->syncp);			\
> > +		}							\
> > +	}								\
> > +	pcpu_stats;							\
> > +})  
> 
> Do these need to be macros? How many different types are used?

Good question. Probably not. I initially had just one macro that I intended to
use twice (the devm variant), but later realized that there is a
chicken-and-egg problem in the code, where the bus (and thus the statistics)
need to be operational before the client device is fully registered, so device
resource allocations aren't allowed at that point.
But this reminds me that not being a device resource, it needs explicit
freeing and I haven't done that. Will fix this memory leak in the next version.

Best regards,

-- 
David Jander

