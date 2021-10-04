Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5734212EF
	for <lists+linux-spi@lfdr.de>; Mon,  4 Oct 2021 17:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbhJDPq2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Oct 2021 11:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbhJDPq1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Oct 2021 11:46:27 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600FFC061745
        for <linux-spi@vger.kernel.org>; Mon,  4 Oct 2021 08:44:38 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id i132so16904724qke.1
        for <linux-spi@vger.kernel.org>; Mon, 04 Oct 2021 08:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0/aP63vy196i8qH5aGLzYmPHF4Nnb+LayDyFtr1MXMg=;
        b=FrrVaLmatO49LvYV8N9t8dOdbGVBJR3uVBoq9V1WS6cSj2Cb1rm4irSPU637X3Eyv9
         XYle6u16GK8tqSmcZsxSml+QoQhROr2ixOlYw/HLYJ0moUkyLT+ARSKEyFM4P2Vf2aVZ
         bHQ5rlQcKN7lXDC26PuHAyymZGCME2n3eKQruQF7BGnnssj52apDsqZ47vaw7CneEVj0
         FbmRF1DEjIiJ6n+vrG4P3iETCVLbIN9IA29e3wqYeJm8Q7sCRb8NuFBkaHIhfa0kgUe7
         OTTt++eukDUH5MZyWsRhjylFCBO9ap9F9k0d6VFXYGnSLUhrgW/TGUYiQYgBmpTnuwrV
         3xsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0/aP63vy196i8qH5aGLzYmPHF4Nnb+LayDyFtr1MXMg=;
        b=NkwmywFB5EcBj1P3iFdKxM2Ahu8zmlBz5oiJhh2/vjRbYUyH/F/Dei13S3xx8kPj+Y
         UsOLtVA7CAXCIC9PY6+z9W7+edQ2z9TvbPRhVhtqU+AHCKPSn1F27bjrHEjzD7mI5HyE
         IER7to3mT0WUuk8p21FV8RWjV9DwwF22D7dygMjyz8BnfTVifSPElELOjGGPX3OLovPB
         4YMKwtYxvKvp71FJG6N1wZCW5UZQTqnzVXFKjnUmy6OeZtK3f4BgNamhgWdhxP6Aq5CK
         StBmHywjDVsTtL+fa976E4wsllcKnTY0ZOxHLkW+Djft5f+uKZvu3rnFbcFg7R4HJA6a
         pbFQ==
X-Gm-Message-State: AOAM532dMY1dY7wojK431AujNyV/MvE85sdBRoE/lRW3vHEk2B3A+Q1/
        /F6BwOsIL5XHv6SJ+BkvWcnDwQ==
X-Google-Smtp-Source: ABdhPJzmrnxoimB1jf2ei4cUIinalbPGsZ26WCIenMwLucficq046xW8YP3iE+lNnoSolu8XpL/UpQ==
X-Received: by 2002:a37:670d:: with SMTP id b13mr10467091qkc.420.1633362277573;
        Mon, 04 Oct 2021 08:44:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id h66sm7850926qkc.5.2021.10.04.08.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 08:44:36 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mXQ8q-00AW43-2f; Mon, 04 Oct 2021 12:44:36 -0300
Date:   Mon, 4 Oct 2021 12:44:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mark Brown <broonie@kernel.org>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, nsaenz@kernel.org,
        linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        p.rosenberger@kunbus.com, linux-integrity@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] spi: bcm2835: do not unregister controller in shutdown
 handler
Message-ID: <20211004154436.GY3544071@ziepe.ca>
References: <20210928195657.5573-1-LinoSanfilippo@gmx.de>
 <20211001175422.GA53652@sirena.org.uk>
 <2c4d7115-7a02-f79e-c91b-3c2dd54051b2@gmx.de>
 <YVr4USeiIoQJ0Pqh@sirena.org.uk>
 <20211004131756.GW3544071@ziepe.ca>
 <YVsLxHMCdXf4vS+i@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVsLxHMCdXf4vS+i@sirena.org.uk>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Oct 04, 2021 at 03:12:20PM +0100, Mark Brown wrote:
> On Mon, Oct 04, 2021 at 10:17:56AM -0300, Jason Gunthorpe wrote:
> 
> > Shutdown is supposed to quiet the HW so it is not doing DMAs any
> > more. This is basically an 'emergency' kind of path, the HW should be
> > violently stopped if available - ie clearing the bus master bits on
> > PCI, for instance.
> 
> > When something like kexec happens we need the machine to be in a state
> > where random DMA's are not corrupting memory.
> 
> That's all well and good but there's no point in implementing something
> half baked that's opening up a whole bunch of opportunities to crash the
> system if more work comes in after it's half broken the device setup.  

Well, that is up to the driver implementing this. It looks like device
shutdown is called before the userspace is all nuked so yes,
concurrency with userspace is a possible concern here.

> > Due to the emergency sort of nature it is not appropriate to do
> > locking complicated sorts of things like struct device unregistrations
> > here.
> 
> That's just not what's actually implemented in a bunch of places, nor
> something one would infer from the documentation ("Called at shut-down
> to quiesce the device", no mention of emergency cases which I'd guess
> would just be kdump) - 

Drivers mis understanding stuff is not new..

> that's a different thing and definitely abusing the API.  I would guess
> that a good proportion of people implementing it are more worried about
> clean system shutdown than they are about kdump.

The other important case is to get the device cleaned up enough to
pass back to firmware for platforms that use a firmware
shutdown/reboot path.

Jason
