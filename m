Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 105621641A
	for <lists+linux-spi@lfdr.de>; Tue,  7 May 2019 14:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfEGM5e (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 May 2019 08:57:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35323 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfEGM5e (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 May 2019 08:57:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so19895276wmd.0
        for <linux-spi@vger.kernel.org>; Tue, 07 May 2019 05:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/RaXXBk8jojDKv8ZmQ0ryO/koLyatTNCLWmxjtwxqGc=;
        b=iopnbCEUtg1eAxFuU08UrnyeGqTI+HGYI7hLhiCz6a8D7KehZIhwl7APdw7pnq8V8f
         5v6f2Lclyksgs1+8aRGEqs2y8Zcs9PwH2fjM5t6NYDSozt7EBXN3QoQlitjVL5zfa3t0
         40LZTE68pOiz37WL82Gm43xJG5y8cv4aUlMgGThFR6BR89N3BHdZos+aARYT6ewxG/iZ
         t/yya9uEPJyp8q+5aBvbopkeAgmiUsC/7kRRvdooul36Sc5Sd2XDkc5IkQfNe9g0V4EF
         THePO2G+D4ADC2I6Gl9r3RM1wUB+N3En8hGtRpx3W1tMLZyVzmzqhKm6QK0Dcxj0PtAi
         3BMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/RaXXBk8jojDKv8ZmQ0ryO/koLyatTNCLWmxjtwxqGc=;
        b=Y6FxFp5R/EVjzb3sgaYxPnqaoHZ7udwOsLHCNtatouRuBgG0Uh+yY6jGv4X+VRRHsA
         FjF4gbTVc64Sbyi08oEFWeH04MeGDDpzy1NaLIVHi4abD4wh7AlPQnvxHmmIKUOEGpal
         a2Sr14VVDHqqwibWShbBoEedTnnDpTrk9cwowo1Cawjs/VTIpc95B7mZE2L7eyhZ5fQ4
         J9lToJbPmjhykvD4kwWSSD2GV+w4ifkPMaByc/FZqY/Jh/ivi1wkU3Tm6Vo63oKH7gqj
         EHBHOF1mpV3MQweYWF01gvVFjyYir/oEQCO3liA6Ss0cg4WrblG8uOijfGEvnGL6WA/s
         5muQ==
X-Gm-Message-State: APjAAAXhETOYY+9dGgjN8KhIZUFzNXqVFd9Vs4xZdpjHMI9Hom/of/Oc
        jIvdUlPn8+6Cow+H7TPLKbOOhQ==
X-Google-Smtp-Source: APXvYqxfXo1lWPeAKtlRyEL3cx6RJOPy4WmqDUMfvFj0NINxzhHchVHKD/CQSUXUaH2ov9alSw3E/Q==
X-Received: by 2002:a1c:2c89:: with SMTP id s131mr9244361wms.142.1557233852944;
        Tue, 07 May 2019 05:57:32 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id o130sm13593961wmo.43.2019.05.07.05.57.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 05:57:32 -0700 (PDT)
Date:   Tue, 7 May 2019 13:57:30 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        sergei.shtylyov@cogentembedded.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, juliensu@mxic.com.tw,
        Simon Horman <horms@verge.net.au>, zhengxunli@mxic.com.tw
Subject: Re: [PATCH v12 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
 RPC-IF MFD bindings
Message-ID: <20190507125730.GD29524@dell>
References: <1556092536-17095-1-git-send-email-masonccyang@mxic.com.tw>
 <1556092536-17095-4-git-send-email-masonccyang@mxic.com.tw>
 <20190424212356.GA27103@bogus>
 <65853dc2-6f3c-1494-7e72-54877797cdd2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65853dc2-6f3c-1494-7e72-54877797cdd2@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 24 Apr 2019, Marek Vasut wrote:

> On 4/24/19 11:23 PM, Rob Herring wrote:
> > On Wed, Apr 24, 2019 at 03:55:36PM +0800, Mason Yang wrote:
> >> Document the bindings used by the Renesas R-Car Gen3 RPC-IF MFD.
> >>
> >> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> >> ---
> >>  .../devicetree/bindings/mfd/mfd-renesas-rpc.txt    | 40 ++++++++++++++++++++++
> >>  1 file changed, 40 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
> >> new file mode 100644
> >> index 0000000..668b822
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
> >> @@ -0,0 +1,40 @@
> >> +Renesas R-Car Gen3 RPC-IF MFD Device Tree Bindings
> >> +--------------------------------------------------
> > 
> > Looks like a SPI flash controller from the example. What makes it an 
> > MFD?
> 
> It supports both SPI NOR and HyperFlash (CFI-compliant flash with
> different bus interface).

Looks like you're registering one OR the other.

Why don't you just do this from DT?

No reason for this to be an MFD IMHO.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
