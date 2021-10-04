Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567CD4214E8
	for <lists+linux-spi@lfdr.de>; Mon,  4 Oct 2021 19:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbhJDROx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Oct 2021 13:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236443AbhJDROw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Oct 2021 13:14:52 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A20C061749
        for <linux-spi@vger.kernel.org>; Mon,  4 Oct 2021 10:13:03 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id c20so16560800qtb.2
        for <linux-spi@vger.kernel.org>; Mon, 04 Oct 2021 10:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cOKjddDH5+4xS9V6U2CWaH8D4d1KqVMcYRtfQMaTs5c=;
        b=GgvWKF+Qow1pRmPozvXwK2n6+vlzlAdHg6CBoGnUsGSCYEVdzLPd45F7dE6qGax55W
         uIZXUFTGdekCCcreTwaTXheY/u4z2Htz1g2kRHKpkvOjcN7f9zK83dzPuh36ynHbAj5r
         Q0khND2u9HtkPw+KjpvYUFBXWsR+ItBJjfAn2U2Zxrx3MEB63rzpJWoot7UvfQCk6YfW
         IwQEebSORZ1pdAiMpCIg3xzfCmjRrNJlswM7uqD+Ei7mVjWfa3RP2U+6lKdPt4ub+2MK
         vQUGdOTByuoOBxPzrJiOvrS8wxIeXzQoY3i9NFRVPcpqoDY3nsjb74rbLQb4AXYrn/6q
         QCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cOKjddDH5+4xS9V6U2CWaH8D4d1KqVMcYRtfQMaTs5c=;
        b=P9RuRpNZbuJ3oErz/JfCFl4+QwTGuJiDxcn4lhBEqt/zdT9jTsk/5TE6a1aAguIE+C
         8Dvnz2Ul9nS4KS7aVAni8Gb1kGyPHjRkUpwGeCABACZuu+5DWVbcUi9FWnrSlpAY4Atx
         BydcpfP8uDcLUVfQbIsnZJPHzvgbHWHYttDh0KWf2N+obKRv2m0zb9p2CITPYO6GbNWw
         lizOQzs6f3c+eIo63dagGOgEyADWw5TEag9goE5jUYV4+dHMh9r5V+B1V0Eu4u7B+N6a
         7drpGegvDAxjYktEwtU7MKV+mgv5qa+EJHEMINquswHe08dNmryj00hq/NRff3/mpsD8
         RE3A==
X-Gm-Message-State: AOAM532U5VSZfMgFw8WTiF0YL9xk0snbHqkaQJwYXTy/rCjLEpIwyGJa
        hPQ6tmpOPupY+oK+g1/D9LMcBg==
X-Google-Smtp-Source: ABdhPJyHXh9xAEaI+chzKoDCbjRMjAzxAmOsUGwwrilg5S3YihxeXByibrc9cOiMrfCR5Vojnwty/g==
X-Received: by 2002:ac8:709a:: with SMTP id y26mr14324507qto.142.1633367582734;
        Mon, 04 Oct 2021 10:13:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id h14sm8793364qkn.4.2021.10.04.10.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 10:13:02 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mXRWP-00AXWA-O2; Mon, 04 Oct 2021 14:13:01 -0300
Date:   Mon, 4 Oct 2021 14:13:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        nsaenz@kernel.org, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        p.rosenberger@kunbus.com, linux-integrity@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] spi: bcm2835: do not unregister controller in shutdown
 handler
Message-ID: <20211004171301.GA3544071@ziepe.ca>
References: <20211001175422.GA53652@sirena.org.uk>
 <2c4d7115-7a02-f79e-c91b-3c2dd54051b2@gmx.de>
 <YVr4USeiIoQJ0Pqh@sirena.org.uk>
 <20211004131756.GW3544071@ziepe.ca>
 <YVsLxHMCdXf4vS+i@sirena.org.uk>
 <20211004154436.GY3544071@ziepe.ca>
 <YVssWYaxuQDi8jI5@sirena.org.uk>
 <e68b04ab-831b-0ed5-074a-0879194569f9@gmail.com>
 <20211004165127.GZ3544071@ziepe.ca>
 <f481f7cc-6734-59b3-6432-5c2049cd87ea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f481f7cc-6734-59b3-6432-5c2049cd87ea@gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Oct 04, 2021 at 09:55:32AM -0700, Florian Fainelli wrote:
> On 10/4/21 9:51 AM, Jason Gunthorpe wrote:
> > On Mon, Oct 04, 2021 at 09:36:37AM -0700, Florian Fainelli wrote:
> > 
> >> No please don't, I should have arguably justified the reasons why
> >> better, but the main reason is that one of the platforms on which this
> >> driver is used has received extensive power management analysis and
> >> changes, and shutting down every bit of hardware, including something as
> >> small as a SPI controller, and its clock (and its PLL) helped meet
> >> stringent power targets.
> > 
> > Huh? for device shutdown? What would this matter if the next step is
> > reboot or power off?
> 
> Power off, the device is put into a low power state (equivalent to ACPI
> S5) and then a remote control key press, or a GPIO could wake-up the
> device again. While it is in that mode, it consumes less than 0.5W(AC).
> Imagine your stick/cast/broom behind your TV falling in that category.

So really this is more of a very deep sleep that cannot be recovered
from than what other platforms would call a shutdown - eg the
powerdomain of the device under driver control will not loose
power.

I'm kind of surprised a scheme like this didn't involve a FW call
after Linux is done with the CPUs to quiet all the HW and let it
sleep, I've built things that way before at least.

> I am fairly sure that no driver write knows about the being bound in
> time aspect.

Well, it is a logical consequence. The system is shutting down, no
driver should be designed to deadlock the shutdown forever.

I suppose this is why I've occasionally seen Linux just hang at a
black screen and no power off when told to shutdown :)

Jason
