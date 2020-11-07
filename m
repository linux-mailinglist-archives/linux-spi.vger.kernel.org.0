Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231962AA5AD
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 15:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgKGODJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 09:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgKGODJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 09:03:09 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFE9C0613CF;
        Sat,  7 Nov 2020 06:03:09 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id r12so1833370qvq.13;
        Sat, 07 Nov 2020 06:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8E0Y2gz0Cx03JNF6tn6/f94ykdO43Amm9xSOcaF5JQs=;
        b=WfTKL2HNtkzosF+Kk0Qh7Ek/HWatLw9vB4ZtcCu/W/cxFHFaHbJO/MUudBw4HE1AbL
         GHZT//XL7c8R/tAB+q9dpfsx5ykoyYcx9IV6PxOGpVKBkMYfgrWBP2jffurCtiucHpJo
         egFR9RWMcaBUgd5MKglRpd+nc4WfmGPv+Kypi2A6ypxydMV52jzH3kAtyEPuwqCdvACf
         is1itg5mhf0Q/ds+sJfL/zHwqIgpJkgnVwHJkZKoJ/EbsxLScyJk7qDxwuGamXt2K14Q
         4AUJ0TmbS1mBGOs6FYgEKrDzV7bRgLtz6TFdqZo3ATLJ9E70FPSnusPxNcp4OureBRzZ
         XPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8E0Y2gz0Cx03JNF6tn6/f94ykdO43Amm9xSOcaF5JQs=;
        b=X7u2nnpjhZWSFZnh9DCAQQRFwGMypOZYkJQCvU/0yysXIjkBQqzlldmLF930e4nKhU
         6iQRRJbsIlMmI6nY1zm5deyhES/Yiy1Y5E6KcWjUdqP8EKuaCpShEs+2W19mL9XrO0Hx
         Bi4rKEISFV5FgPaoqNh1DiqRh2XYiWqiRa91FHbyLAqulBLcZ09rqh6prAgWoUZv9HyS
         D2fYMTWLWzobajov3dlZJJZ4tNZ0QTxecoWBCbxLvDk1xBQVmD/oT6/Zl1zf/NbFENvk
         kbjPdWFKX6GnTDHTCQXjdIktt+7ZlNZfk6yhbXLJknhWk56cFPa+k68Szsx86xUpoaei
         We6w==
X-Gm-Message-State: AOAM532Z+pXZsU0wdf/LMpA1NLg8vHbNsxMHDmtyTD+UJCn3eL9+js7a
        XfymNRUJwbStq4rVVhZ88lI=
X-Google-Smtp-Source: ABdhPJwbqcHjLXg5tx4/MH3uPMpVg2VJ5PVO3qVyhchEoYN+MIOaW4mW1lbhofasTce1kPelAKETDw==
X-Received: by 2002:ad4:45d2:: with SMTP id v18mr6056079qvt.45.1604757788415;
        Sat, 07 Nov 2020 06:03:08 -0800 (PST)
Received: from [192.168.1.201] (pool-108-51-35-162.washdc.fios.verizon.net. [108.51.35.162])
        by smtp.googlemail.com with ESMTPSA id z125sm2590613qke.54.2020.11.07.06.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2020 06:03:07 -0800 (PST)
Subject: Re: [PATCH 21/32] dt-bindings: Add Kendryte and Canaan vendor prefix
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-22-damien.lemoal@wdc.com>
From:   Sean Anderson <seanga2@gmail.com>
Autocrypt: addr=seanga2@gmail.com; prefer-encrypt=mutual; keydata=
 mQENBFe74PkBCACoLC5Zq2gwrDcCkr+EPGsT14bsxrW07GiYzQhLCgwnPdEpgU95pXltbFhw
 46GfyffABWxHKO2x+3L1S6ZxC5AiKbYXo7lpnTBYjamPWYouz+VJEVjUx9aaSEByBah5kX6a
 lKFZWNbXLAJh+dE1HFaMi3TQXXaInaREc+aO1F7fCa2zNE75ja+6ah8L4TPRFZ2HKQzve0/Y
 GXtoRw97qmnm3U36vKWT/m2AiLF619F4T1mHvlfjyd9hrVwjH5h/2rFyroXVXBZHGA9Aj8eN
 F2si35dWSZlIwXkNu9bXp0/pIu6FD0bI+BEkD5S7aH1G1iAcMFi5Qq2RNa041DfQSDDHABEB
 AAG0K1NlYW4gR2FsbGFnaGVyIEFuZGVyc29uIDxzZWFuZ2EyQGdtYWlsLmNvbT6JAVcEEwEK
 AEECGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4ACGQEWIQSQYR1bzo1I0gPoYCg+6I/stKEQ
 bgUCXT+S2AUJB2TlXwAKCRA+6I/stKEQbhNOB/9ooea0hU9Sgh7PBloU6CgaC5mlqPLB7NTp
 +JkB+nh3Fqhk+qLZwzEynnuDLl6ESpVHIc0Ym1lyF4gT3DsrlGT1h0Gzw7vUwd1+ZfN0CuIx
 Rn861U/dAUjvbtN5kMBqOI4/5ea+0r7MACcIVnKF/wMXBD8eypHsorT2sJTzwZ6DRCNP70C5
 N1ahpqqNmXe0uLdP0pu55JCqhrGw2SinkRMdWyhSxT56uNwIVHGhLTqH7Q4t1N6G1EH626qa
 SvIJsWlNpll6Y3AYLDw2/Spw/hqieS2PQ/Ky3rPZnvJt7/aSNYsKoFGX0yjkH67Uq8Lx0k1L
 w8jpXnbEPQN3A2ZJCbeM
Message-ID: <6fcfabd4-210a-c947-6151-4f8f3b3a9e25@gmail.com>
Date:   Sat, 7 Nov 2020 09:03:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201107081420.60325-22-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 11/7/20 3:14 AM, Damien Le Moal wrote:
> Update Documentation/devicetree/bindings/vendor-prefixes.yaml to include
> "Kendryte" and "canaan" as a vendor prefix for "Canaan Inc."
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 2735be1a8470..f53d4d8e7f2a 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -179,6 +179,8 @@ patternProperties:
>      description: CALAO Systems SAS
>    "^calxeda,.*":
>      description: Calxeda
> +  "^canaan,.*":
> +    description: Canaan, Inc.
>    "^caninos,.*":
>      description: Caninos Loucos Program
>    "^capella,.*":
> @@ -537,6 +539,8 @@ patternProperties:
>      description: Ka-Ro electronics GmbH
>    "^keithkoep,.*":
>      description: Keith & Koep GmbH
> +  "^kendryte,.*":
> +    description: Canaan, Inc.
>    "^keymile,.*":
>      description: Keymile GmbH
>    "^khadas,.*":
> 

So AFAIK Canaan is the company, and Kendryte is the brand. However, I
was unaware of this when I did my initial porting work. So all the
compatible strings like "kendryte,k210-foo" should really be
"canaan,kendryte-k210-foo". These _should_ all get fixed in the device
tree, but no one has done it yet.

--Sean
