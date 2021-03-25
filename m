Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4883485C7
	for <lists+linux-spi@lfdr.de>; Thu, 25 Mar 2021 01:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbhCYASS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Mar 2021 20:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbhCYAR5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 Mar 2021 20:17:57 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881C9C06174A;
        Wed, 24 Mar 2021 17:17:57 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id l3so182582pfc.7;
        Wed, 24 Mar 2021 17:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rSwRkHBJHbuZ/EIRIaLb7YqX/KnAfx7g33QtZKoYZB4=;
        b=OMHQ9F1RfQ0SVATop4AnZ5aUXxBDyBmNZwyn1hbcdg/SNyNrfGo7nEcfZb5JuEzVti
         8NBAfOtSBgZ4g4qqBe+Zyq49Of4JlUve2bc9llsJotNBPObA1fwPb97FKVUlq7IVo9Sr
         jKpjIX83TBL6cHH4YoTZypWQhPrDD17L1jZg/50c0VUMm219X6XmvCMo4djRoylXMId/
         //jZvV9tKFr7hS5Aa3uUallQz57aK4XrP11l2Zhx0RIun5A8ZpdEDowvRijaLXucdSQc
         KanZRoq/HE4CRywnLRo75No2qoGxYeUHOIGPlFJ2tfTNze4N/9L/Ex29jfaxcBc4w58/
         /JeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rSwRkHBJHbuZ/EIRIaLb7YqX/KnAfx7g33QtZKoYZB4=;
        b=PmVltDLm/0RRViaDAYyMcWssjA9qa+nIfNTf2eGzXiZ4wwqEDzQKD9mJ7afsw+Exca
         J78ufS8PHka2c4aX27hlRI3hPaGgSzhXHkJAK7aor0X3sdNY7cWyBFSn2sGL3w53DvHz
         6p3/xNrNI3DpeDjQRxsFGUnJ3ztIC/2Tmw8xU5aW5d2Qr/l/U+d4lXYT6kcPLgNOIkd4
         sKMbPKatQDHvS3TrfuWVCxmH+RRtcqKmCOzjeUERJa4KHuIiSMHgubbPg7hvvblXXug2
         e17q2+TK6BIiGBqaPrmvnIU+cHAAUOheWjv4lUoHhazVMChqTRBceIwb+uYKn4fkn32O
         uKSg==
X-Gm-Message-State: AOAM533pt6LkT1C5MEgdvX7vfkNrqgQFmjPgGvtPTIDVwO2D+3ZxAvD/
        J4WBYI9FOTmuuQfo679vLC4=
X-Google-Smtp-Source: ABdhPJz3ijUl0Pt6+vmueInx+Zovjsyn+br7EcB2aw94ET6rQRfV+NRqMB/hACkGVfRCsI04BiHZ5w==
X-Received: by 2002:aa7:969d:0:b029:1f5:b02c:eed3 with SMTP id f29-20020aa7969d0000b02901f5b02ceed3mr5288599pfk.75.1616631476832;
        Wed, 24 Mar 2021 17:17:56 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:4d6b:ca5a:c720:f5c9])
        by smtp.gmail.com with ESMTPSA id 195sm3505270pge.7.2021.03.24.17.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 17:17:55 -0700 (PDT)
Date:   Wed, 24 Mar 2021 17:17:52 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: ensure timely release of driver-allocated resources
Message-ID: <YFvWsA3WnMAqVLGU@google.com>
References: <YFf2RD931nq3RudJ@google.com>
 <20210322123707.GB4681@sirena.org.uk>
 <YFjyJycuAXdTX42D@google.com>
 <20210323173606.GB5490@sirena.org.uk>
 <YFo7wkq037P2Dosz@google.com>
 <20210324213225.GD4596@sirena.org.uk>
 <YFu8y9CuG6Mouxnq@google.com>
 <20210324233935.GE4596@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324233935.GE4596@sirena.org.uk>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Mar 24, 2021 at 11:39:35PM +0000, Mark Brown wrote:
> On Wed, Mar 24, 2021 at 03:27:23PM -0700, Dmitry Torokhov wrote:
> > On Wed, Mar 24, 2021 at 09:32:26PM +0000, Mark Brown wrote:
> 
> > > TBH that looks like a fairly standard case where you probably don't want
> > > to be using devm for the interrupts in the first place.  Leaving the
> > > interrupts live after the bus thinks it freed the device doesn't seem
> > > like the best idea, I'm not sure I'd expect that to work reliably when
> > > the device tries to call into the bus code to interact with the device
> > > that the bus thought was already freed anyway.
> > 
> > That is not an argument really. By that token we should not be using
> > devm for anything but memory, and that is only until we implement some
> > kind of memleak checker that will ensure that driver-allocated memory is
> > released after driver's remove() method exits.
> 
> I pretty much agree with that perspective TBH, I rarely see interrupt
> users that I conside safe.  It's the things that actively do stuff that
> cause issues, interrupts and registration of userspace interfaces both
> being particularly likely to do so as work comes in asynchronously.
> 
> > You also misread that the issue is limited to interrupts, when i fact
> > in this particular driver it is the input device that is being
> > unregistered too late and fails to timely quiesce the device. Resulting
> > interrupt storm is merely a side effect of this.
> 
> My understanding was that the issue is that the driver is generating
> work because the interrupt is firing, if the interrupt had been
> unregistered we'd not be getting the interupts delivered (probably
> they'd have been disabled at the interrupt controller level) and not
> have the problem of trying to handle them on a partially unwound device.

Yes, but the root of the problem is that we rely that the device will be
stopped when input core "closes" it upon device unregistering, so even
if we did not have this particular issue with interrupt storm we would
still be at risk of accessing half-dead device. What I am trying to say
(and I believe we are actually agreeing with each other) is that not
only interrupts, but other devm-allocated objects are also can cause
problems here.

> 
> > > looked at.  Possibly we want a driver core callback which is scheduled
> > > via devm (remove_devm(), cleanup() or something).  We'd still need to
> > > move things about in all the buses but it seems preferable to do it that
> > > way rather than open coding opening a group and the comments about
> > > what's going on and the ordering requirements everywhere, it's a little
> > > less error prone going forward.
> 
> > From the driver's perspective they expect devm-allocated resources to
> > happen immediately after ->remove() method is run. I do not believe any
> > driver is interested in additional callback, and you'd need to modify
> > a boatload of drivers to fix this issue.
> 
> Not a callback for the device drivers, for the buses.  This is
> essentially about converting the unwinding the bus does to be sequenced
> for devm.

Ah, OK.

> 
> > I agree with you that manual group handling might be a bit confusing
> > and sprinkling the same comment everywhere is not too nice, so how about
> > we provide:
> 
> > 	void *devm_mark_driver_resources(struct device *dev)
> 
> > and
> 
> > 	void devm_release_driver_resources()
> 
> > and keep the commentary there? The question is where to keep
> > driver_res_id field - in generic device structure or put it into bus'
> > device structure as some buses and classes do not need it and we'd be
> > sawing 4-8 bytes per device structure this way.
> 
> I guess bus' device :/
> 
> > Another way is to force buses to use devm for their resource management
> > (I.e. in case of SPI wrap dev_pm_domain_detach() in
> > devm_add_action_or_release()). It works for buses that have small number
> > of resource allocated, but gets more unwieldy and more expensive the
> > more resources are managed at bus level, that is why I opted for opening
> > a group.
> 
> If the driver core were doing it and scheduling a single callback the
> bus provides then that callback could do as much as it likes...

OK, I can look into it. In the meantime wills something like below a bit
easier for you to stomach? If so I'll resubmit formally.

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c19a09201358..a0db83bcb3d4 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -375,6 +375,11 @@ static int spi_uevent(struct device *dev, struct kobj_uevent_env *env)
 	return add_uevent_var(env, "MODALIAS=%s%s", SPI_MODULE_PREFIX, spi->modalias);
 }
 
+static void spi_dev_pm_domain_detach(void *_dev)
+{
+	dev_pm_domain_detach(_dev, true);
+}
+
 static int spi_probe(struct device *dev)
 {
 	const struct spi_driver		*sdrv = to_spi_driver(dev->driver);
@@ -421,11 +426,12 @@ static int spi_probe(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (sdrv->probe) {
+	ret = devm_add_action_or_reset(dev, spi_dev_pm_domain_detach, dev);
+	if (ret)
+		return ret;
+
+	if (sdrv->probe)
 		ret = sdrv->probe(spi);
-		if (ret)
-			dev_pm_domain_detach(dev, true);
-	}
 
 	return ret;
 }
@@ -444,8 +450,6 @@ static int spi_remove(struct device *dev)
 				 ERR_PTR(ret));
 	}
 
-	dev_pm_domain_detach(dev, true);
-
 	return 0;
 }
 

-- 
Dmitry
