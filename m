Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8DD53132D
	for <lists+linux-spi@lfdr.de>; Mon, 23 May 2022 18:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237688AbiEWPNh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 May 2022 11:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237681AbiEWPNa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 23 May 2022 11:13:30 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B075D5FA
        for <linux-spi@vger.kernel.org>; Mon, 23 May 2022 08:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=aK2P4KfT/jagGRGtn5s8eLRa/X+1+fvfvxYe8M6Qbek=; b=BCQFd11CWm/zDRtXBKlECIl90G
        NC7SLHI6aC+LpeY6He0kntpoXnujlrrsou6KEQO5YnBFiTe0J+M8Oqpzwe3WiyrkZl5yQQ0F71zua
        AnSewcb+wU0X00YVH/12miwslQQ3wS9yxL54LbGkccELGxVxHvNZjNl1KUeSw/xiLmIY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nt9kC-003zyL-CB; Mon, 23 May 2022 17:13:16 +0200
Date:   Mon, 23 May 2022 17:13:16 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     David Jander <david@protonic.nl>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] drivers: spi: spi.c: Convert statistics to per-cpu
 u64_stats_t
Message-ID: <YoukjLDGvz5kN5fp@lunn.ch>
References: <20220523142009.2218738-1-david@protonic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523142009.2218738-1-david@protonic.nl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, May 23, 2022 at 04:20:09PM +0200, David Jander wrote:
> This change gives a dramatic performance improvement in the hot path,
> since many costly spin_lock_irqsave() calls can be avoided.

It is normal to back up such claims with numbers. Please include your
numbers here.

> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: David Jander <david@protonic.nl>
> ---
>  drivers/spi/spi.c       | 95 ++++++++++++++++++++++++-----------------
>  include/linux/spi/spi.h | 80 ++++++++++++++++++++++++----------
>  2 files changed, 114 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index c4dd1200fe99..edc290e67b92 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -33,6 +33,7 @@
>  #include <linux/idr.h>
>  #include <linux/platform_data/x86/apple.h>
>  #include <linux/ptp_clock_kernel.h>
> +#include <linux/percpu.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/spi.h>
> @@ -111,6 +112,25 @@ static ssize_t driver_override_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RW(driver_override);
>  
> +#define spi_pcpu_stats_totalize(ret, in, field)				\
> +do {									\
> +	int i;								\
> +	ret = 0;							\
> +	for_each_possible_cpu(i) {					\
> +		const struct spi_statistics *pcpu_stats;		\
> +		u64 inc;						\
> +		unsigned int start;					\
> +		pcpu_stats = per_cpu_ptr(in, i);			\
> +		do {							\
> +			start = u64_stats_fetch_begin_irq(		\
> +					&pcpu_stats->syncp);		\
> +			inc = u64_stats_read(&pcpu_stats->field);	\
> +		} while (u64_stats_fetch_retry_irq(			\
> +					&pcpu_stats->syncp, start));	\
> +		ret += inc;						\
> +	}								\
> +} while (0)

Looking at this from the perspective of a network reviewer, that is a
pretty big macro. netdev would probably not allow this. But macro
magic does seem normal in this file.

What also makes a difference here is the API to user space. With
netdev, it is not so much the absolute values of the counters, but the
relationship with other counters that is interesting. So there is a
method to get all the counters in one atomic snapshot. For that to
work, the loop doing the addition adds up all the counters, not just
one specific counter. So there is no need for 'field' which is the
source of all this macro magic. But it seems like SPI only ever
exports individual counters.

>  #define SPI_STATISTICS_ATTRS(field, file)				\
>  static ssize_t spi_controller_##field##_show(struct device *dev,	\
>  					     struct device_attribute *attr, \
> @@ -118,7 +138,7 @@ static ssize_t spi_controller_##field##_show(struct device *dev,	\
>  {									\
>  	struct spi_controller *ctlr = container_of(dev,			\
>  					 struct spi_controller, dev);	\
> -	return spi_statistics_##field##_show(&ctlr->statistics, buf);	\
> +	return spi_statistics_##field##_show(ctlr->pcpu_statistics, buf); \
>  }									\
>  static struct device_attribute dev_attr_spi_controller_##field = {	\
>  	.attr = { .name = file, .mode = 0444 },				\
> @@ -129,7 +149,7 @@ static ssize_t spi_device_##field##_show(struct device *dev,		\
>  					char *buf)			\
>  {									\
>  	struct spi_device *spi = to_spi_device(dev);			\
> -	return spi_statistics_##field##_show(&spi->statistics, buf);	\
> +	return spi_statistics_##field##_show(spi->pcpu_statistics, buf); \
>  }									\
>  static struct device_attribute dev_attr_spi_device_##field = {		\
>  	.attr = { .name = file, .mode = 0444 },				\

Not a criticism of this patch, but this is the old way to do this. It
is better to use DEVICE_ATTR_RO(), but that is a bigger rework.

> @@ -140,11 +160,10 @@ static struct device_attribute dev_attr_spi_device_##field = {		\
>  static ssize_t spi_statistics_##name##_show(struct spi_statistics *stat, \
>  					    char *buf)			\
>  {									\
> -	unsigned long flags;						\
>  	ssize_t len;							\
> -	spin_lock_irqsave(&stat->lock, flags);				\
> -	len = sysfs_emit(buf, format_string "\n", stat->field);		\
> -	spin_unlock_irqrestore(&stat->lock, flags);			\
> +	u64 val;							\
> +	spi_pcpu_stats_totalize(val, stat, field);			\
> +	len = sysfs_emit(buf, format_string "\n", val);			\

If you have made all the statistics u64, you don't need format_string.

> @@ -543,7 +562,7 @@ struct spi_device *spi_alloc_device(struct spi_controller *ctlr)
>  	spi->dev.release = spidev_release;
>  	spi->mode = ctlr->buswidth_override_bits;
>  
> -	spin_lock_init(&spi->statistics.lock);
> +	spi->pcpu_statistics = spi_alloc_pcpu_stats(struct spi_statistics);

It looks like you are missing error checking here.

> @@ -3042,7 +3061,7 @@ int spi_register_controller(struct spi_controller *ctlr)
>  		}
>  	}
>  	/* add statistics */
> -	spin_lock_init(&ctlr->statistics.lock);
> +	ctlr->pcpu_statistics = devm_spi_alloc_pcpu_stats(dev, struct spi_statistics);

This could fail, so you should check for NULL pointer.

> +#define devm_spi_alloc_pcpu_stats(dev, type)				\
> +({									\
> +	typeof(type) __percpu *pcpu_stats = devm_alloc_percpu(dev, type);\
> +	if (pcpu_stats) {						\
> +		int __cpu;						\
> +		for_each_possible_cpu(__cpu) {				\
> +			typeof(type) *stat;				\
> +			stat = per_cpu_ptr(pcpu_stats, __cpu);		\
> +			u64_stats_init(&stat->syncp);			\
> +		}							\
> +	}								\
> +	pcpu_stats;							\
> +})
> +
> +#define spi_alloc_pcpu_stats(type)					\
> +({									\
> +	typeof(type) __percpu *pcpu_stats = alloc_percpu_gfp(type, GFP_KERNEL);\
> +	if (pcpu_stats) {						\
> +		int __cpu;						\
> +		for_each_possible_cpu(__cpu) {				\
> +			typeof(type) *stat;				\
> +			stat = per_cpu_ptr(pcpu_stats, __cpu);		\
> +			u64_stats_init(&stat->syncp);			\
> +		}							\
> +	}								\
> +	pcpu_stats;							\
> +})

Do these need to be macros? How many different types are used?

   Andrew
