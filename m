Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D99A116FB2
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2019 05:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfEHDwV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 May 2019 23:52:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39797 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfEHDwU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 May 2019 23:52:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id v10so12873287wrt.6;
        Tue, 07 May 2019 20:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DcGjXeg0eS0q2STrcadngNVQ19GQsSpa7hlcxfI3B4w=;
        b=SEz3TTQ7P2fSn4ugPwi0u6SQOWHqRtYz8f4ZGwYieVz5K3SjWGJPrErDMJS4stvwSZ
         OARjhZ/OIEnr/3bpPLKh1WdHeShbiiDh2Phc6T95Mvoy95VOozlZq83lh/nhZ2lFwwgv
         FY7RLe/HvYIrtxBiIUT7WHXwkc5BIq+y8gPKOhbUjUCuRoVp1sKpDUMWAVZ4BE5oEXmx
         LqzyZkO+JuyK+QWYm0vu41jP2fo6aE1SIutPDQ9ioZlHg2Lf+7NpRcwoxRMowNl+9Qj2
         7Pqtbi5NB5z/Ksy4IWy+171sqFjP0wuUymU15ayk+m/PLl7ijHxHPudc/qzpVcekQdgQ
         Tz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DcGjXeg0eS0q2STrcadngNVQ19GQsSpa7hlcxfI3B4w=;
        b=Ab9VB9MXum2uRXCpIp+FxXKGTnsn+TAodLapPr5bfjmVreqyW3g/gbnubmHfdC+/cI
         9ERbgxGpPGVWwK53hZ9+NmPrGBsEk3a5daVxwpzOI2IwUF7kk2weG8DArwWDmxO1lcsp
         VFnP9zK1Kl5ymitm0fcHw2PzZJkh3+DXAor8r9I2/A7S5fncebhH2+qjajYZ0pfgkLd9
         qmIIMbVdA5uGpNexgIplGyyhtmLTIGtuJwe2Kd9l3j7XMQvXCazjmKMdr9GQIxnnA9ga
         CkKrB6h1bPhsjvTDE1Sc5ff7e2Dab9EsXMZ6JQys0Cq7gHO+PglR4EeXNSHzVk8BLON4
         n4dA==
X-Gm-Message-State: APjAAAVL8KzmaaAIiFlHUvt8Tx9YEYCm9aFYx2dXCWisf017XxL+r8wH
        0ZAO1qNmF5WSYvPgIyrPDmr0FgWx
X-Google-Smtp-Source: APXvYqx/aEcgcunoBQTZXNUA4Wom6qxK/g7oa+Sgks4LYMYFspUoBy8SPjla86B/3DjIchWkMU6L4Q==
X-Received: by 2002:adf:c6c3:: with SMTP id c3mr25955128wrh.267.1557287538368;
        Tue, 07 May 2019 20:52:18 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id b124sm875376wmg.21.2019.05.07.20.52.16
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 20:52:17 -0700 (PDT)
Subject: Re: [PATCH v12 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
 RPC-IF MFD bindings
To:     masonccyang@mxic.com.tw, Lee Jones <lee.jones@linaro.org>
Cc:     bbrezillon@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, mark.rutland@arm.com,
        Rob Herring <robh@kernel.org>,
        sergei.shtylyov@cogentembedded.com, zhengxunli@mxic.com.tw
References: <1556092536-17095-1-git-send-email-masonccyang@mxic.com.tw>
 <1556092536-17095-4-git-send-email-masonccyang@mxic.com.tw>
 <20190424212356.GA27103@bogus>
 <65853dc2-6f3c-1494-7e72-54877797cdd2@gmail.com>
 <20190507125730.GD29524@dell>
 <OF08A5650B.8AE8977C-ON482583F4.000E5B1E-482583F4.000F7215@mxic.com.tw>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <d229b19e-351c-c576-b5c4-716d10dad1a0@gmail.com>
Date:   Wed, 8 May 2019 05:52:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <OF08A5650B.8AE8977C-ON482583F4.000E5B1E-482583F4.000F7215@mxic.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 5/8/19 4:48 AM, masonccyang@mxic.com.tw wrote:
> Hi Jones,
> 
>> "Lee Jones" <lee.jones@linaro.org>
>> 2019/05/07 下午 08:58
>>
>> To
>>
>> "Marek Vasut" <marek.vasut@gmail.com>,
>>
>> cc
>>
>> "Rob Herring" <robh@kernel.org>, "Mason Yang"
>> <masonccyang@mxic.com.tw>, broonie@kernel.org, linux-
>> kernel@vger.kernel.org, linux-spi@vger.kernel.org,
>> bbrezillon@kernel.org, linux-renesas-soc@vger.kernel.org, "Geert
>> Uytterhoeven" <geert+renesas@glider.be>,
>> sergei.shtylyov@cogentembedded.com, mark.rutland@arm.com,
>> devicetree@vger.kernel.org, juliensu@mxic.com.tw, "Simon Horman"
>> <horms@verge.net.au>, zhengxunli@mxic.com.tw
>>
>> Subject
>>
>> Re: [PATCH v12 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
>> RPC-IF MFD bindings
>>
>> On Wed, 24 Apr 2019, Marek Vasut wrote:
>>
>> > On 4/24/19 11:23 PM, Rob Herring wrote:
>> > > On Wed, Apr 24, 2019 at 03:55:36PM +0800, Mason Yang wrote:
>> > >> Document the bindings used by the Renesas R-Car Gen3 RPC-IF MFD.
>> > >>
>> > >> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>> > >> ---
>> > >>  .../devicetree/bindings/mfd/mfd-renesas-rpc.txt    | 40 ++++++
>> ++++++++++++++++
>> > >>  1 file changed, 40 insertions(+)
>> > >>  create mode 100644 Documentation/devicetree/bindings/mfd/mfd-
>> renesas-rpc.txt
>> > >>
>> > >> diff --git a/Documentation/devicetree/bindings/mfd/mfd-renesas-
>> rpc.txt b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
>> > >> new file mode 100644
>> > >> index 0000000..668b822
>> > >> --- /dev/null
>> > >> +++ b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
>> > >> @@ -0,0 +1,40 @@
>> > >> +Renesas R-Car Gen3 RPC-IF MFD Device Tree Bindings
>> > >> +--------------------------------------------------
>> > >
>> > > Looks like a SPI flash controller from the example. What makes it an
>> > > MFD?
>> >
>> > It supports both SPI NOR and HyperFlash (CFI-compliant flash with
>> > different bus interface).
>>
>> Looks like you're registering one OR the other.
>>
>> Why don't you just do this from DT?
>>
>> No reason for this to be an MFD IMHO.
> 
> 
> okay, I will patch it back to SPI mode only.

I don't think that's what Lee meant . The controller supports _both_
modes , hence it would have the same compatible string. You just need to
extract the mode of operation from the DT.

-- 
Best regards,
Marek Vasut
