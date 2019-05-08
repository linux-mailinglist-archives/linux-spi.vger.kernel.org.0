Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 304AC170CD
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2019 08:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfEHGL0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 May 2019 02:11:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38777 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfEHGL0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 May 2019 02:11:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id v11so5361389wru.5
        for <linux-spi@vger.kernel.org>; Tue, 07 May 2019 23:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GqEqCNgSxd2APLcFtwFmHcxS1CnmhrSkbjU7782mmEA=;
        b=l13Kn1KUq5zSRAzSwAktRUo1C6jyppWNyv3HllcCtdXrTu4EpW8geG9Iry0cHA2uMf
         pOK265Mrbp8iag3zrgfE0qXUaTXZuGC+FNDTwEJgqKa+FoeBCIN84XDRBA9hXZanzAqM
         dqoOhRA/jPnW2p89bXTLRyO/tq324AKCNEPpsHJ/aiVZUZMXsMogE8I4BrrptyAzy7n+
         LRcFr6ISOPot7ORaO23ZT5UHzXRkqgFVYlIC5iqzOFH9ch8nh4cAESOM7wimzrnadnUI
         zDX67dO/9slLZ91EOtq8okbepSPmze+rKL5wpTtJZTNkH1MPd/T1j9Qk/NXL8lKD4pCX
         TN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GqEqCNgSxd2APLcFtwFmHcxS1CnmhrSkbjU7782mmEA=;
        b=izv+7Lkk3Fojho2KCZUHqyYfLvynPUN3jF6zaDvvvuNSlsjktddresMne7Hgq/V0Xs
         rDOGIGmX2fuzzon5IM5uqZL7ArXbTvBp3SbJx6CfTGr0EFzErzUAn9/l59nw09NnEizD
         REqyc3Gv5gNdumgBU34jaIwKALezjYnCXF4rlRsDX3iZnlIF9ihuSpeQHN+442xvMBon
         YBNrqGB73HofaRXkjZlKaiyfivY5kANBjZwS6nHnuuqeljmsSkSB2iPbsqW4yZCHUvlc
         y5yl3yOjyCGCyKdkUYf1b9oS0gtEIn2XP+OX1AYV66ViDRPBQnyDrcno7tCNvHmu7n6e
         Nh7Q==
X-Gm-Message-State: APjAAAXd5opaEx/ZdH2tJlDt/QQ9pqAmRn3otahXUTH0pgkBWQh31OY0
        8ujjcOiV1wiuq6UVS+zWEYgldQ==
X-Google-Smtp-Source: APXvYqyhLI8rjbMFiYKWUY/0814APcR9oqetQaa4ygCTxANrE1IE/VWJ8JAne09spnjza72PYUlIxw==
X-Received: by 2002:adf:dc8a:: with SMTP id r10mr9548175wrj.15.1557295883528;
        Tue, 07 May 2019 23:11:23 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id k67sm1170939wmb.34.2019.05.07.23.11.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 23:11:22 -0700 (PDT)
Date:   Wed, 8 May 2019 07:11:19 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     masonccyang@mxic.com.tw, bbrezillon@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, mark.rutland@arm.com,
        Rob Herring <robh@kernel.org>,
        sergei.shtylyov@cogentembedded.com, zhengxunli@mxic.com.tw
Subject: Re: [PATCH v12 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
 RPC-IF MFD bindings
Message-ID: <20190508061119.GB7627@dell>
References: <1556092536-17095-1-git-send-email-masonccyang@mxic.com.tw>
 <1556092536-17095-4-git-send-email-masonccyang@mxic.com.tw>
 <20190424212356.GA27103@bogus>
 <65853dc2-6f3c-1494-7e72-54877797cdd2@gmail.com>
 <20190507125730.GD29524@dell>
 <OF08A5650B.8AE8977C-ON482583F4.000E5B1E-482583F4.000F7215@mxic.com.tw>
 <d229b19e-351c-c576-b5c4-716d10dad1a0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d229b19e-351c-c576-b5c4-716d10dad1a0@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 08 May 2019, Marek Vasut wrote:

> On 5/8/19 4:48 AM, masonccyang@mxic.com.tw wrote:
> > Hi Jones,
> > 
> >> "Lee Jones" <lee.jones@linaro.org>
> >> 2019/05/07 下午 08:58
> >>
> >> To
> >>
> >> "Marek Vasut" <marek.vasut@gmail.com>,
> >>
> >> cc
> >>
> >> "Rob Herring" <robh@kernel.org>, "Mason Yang"
> >> <masonccyang@mxic.com.tw>, broonie@kernel.org, linux-
> >> kernel@vger.kernel.org, linux-spi@vger.kernel.org,
> >> bbrezillon@kernel.org, linux-renesas-soc@vger.kernel.org, "Geert
> >> Uytterhoeven" <geert+renesas@glider.be>,
> >> sergei.shtylyov@cogentembedded.com, mark.rutland@arm.com,
> >> devicetree@vger.kernel.org, juliensu@mxic.com.tw, "Simon Horman"
> >> <horms@verge.net.au>, zhengxunli@mxic.com.tw
> >>
> >> Subject
> >>
> >> Re: [PATCH v12 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
> >> RPC-IF MFD bindings
> >>
> >> On Wed, 24 Apr 2019, Marek Vasut wrote:
> >>
> >> > On 4/24/19 11:23 PM, Rob Herring wrote:
> >> > > On Wed, Apr 24, 2019 at 03:55:36PM +0800, Mason Yang wrote:
> >> > >> Document the bindings used by the Renesas R-Car Gen3 RPC-IF MFD.
> >> > >>
> >> > >> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> >> > >> ---
> >> > >>  .../devicetree/bindings/mfd/mfd-renesas-rpc.txt    | 40 ++++++
> >> ++++++++++++++++
> >> > >>  1 file changed, 40 insertions(+)
> >> > >>  create mode 100644 Documentation/devicetree/bindings/mfd/mfd-
> >> renesas-rpc.txt
> >> > >>
> >> > >> diff --git a/Documentation/devicetree/bindings/mfd/mfd-renesas-
> >> rpc.txt b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
> >> > >> new file mode 100644
> >> > >> index 0000000..668b822
> >> > >> --- /dev/null
> >> > >> +++ b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
> >> > >> @@ -0,0 +1,40 @@
> >> > >> +Renesas R-Car Gen3 RPC-IF MFD Device Tree Bindings
> >> > >> +--------------------------------------------------
> >> > >
> >> > > Looks like a SPI flash controller from the example. What makes it an
> >> > > MFD?
> >> >
> >> > It supports both SPI NOR and HyperFlash (CFI-compliant flash with
> >> > different bus interface).
> >>
> >> Looks like you're registering one OR the other.
> >>
> >> Why don't you just do this from DT?
> >>
> >> No reason for this to be an MFD IMHO.
> > 
> > 
> > okay, I will patch it back to SPI mode only.
> 
> I don't think that's what Lee meant . The controller supports _both_
> modes , hence it would have the same compatible string. You just need to
> extract the mode of operation from the DT.

HiSilicon attempted to upstream something similar, only their
controller provided NAND and NOR functionality.  They used different
compatible strings to differentiate between the varying
technologies.

They too tried to use MFD as a means to select between them (which was
also NACKed).  Not sure what they ended up doing, but the original
submission and (half of) the conversation can be found at [0].  Some
more of the thread continues at [1].

Hope that helps.

[0] https://groups.google.com/forum/#!topic/fa.linux.kernel/F6i9o8sfOIw
[1] https://marc.info/?l=devicetree&m=147669165104431&w=2

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
