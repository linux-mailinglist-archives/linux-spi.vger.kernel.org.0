Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576242E2CFB
	for <lists+linux-spi@lfdr.de>; Sat, 26 Dec 2020 04:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgLZDcW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Dec 2020 22:32:22 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:59431 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725973AbgLZDcV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 25 Dec 2020 22:32:21 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 665FE58017B;
        Fri, 25 Dec 2020 22:31:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 25 Dec 2020 22:31:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=J
        0tyBu8KMFU52tUWQWjP9NYwvOSvIW8aK76o5DiD89Q=; b=ImNv5weR0WJBbx5nr
        d+6Bdy7aQFaJCFwXYcKxCsE+LpQr7bbtS8YIvHXDi99Y0hbFR94p74ouDYPnpUCG
        qGJHI7d3UKt7M1gze0JCF88eaJIcvxXQySvXiMyJkEaOl5cGpIr7KTsH45jMZ1bf
        CHwk6zrvYNZMlF2LYwOluD52goG8y38vSI8ok9NAgl12FrwJZgZkChbHL6KwRC/A
        zqmI/2mVwd1FxAOdTj6Li4SIaNqK5odB0VdGB7K7cxgZXzdzY3U6Pf1+r2qSTemY
        x13bF215yteGTlu9BkQyECoMuVeuvoBMu/MLBrGOD3n6nQO2mmD3RnrIBKIA4ZtG
        V3p4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=J0tyBu8KMFU52tUWQWjP9NYwvOSvIW8aK76o5DiD8
        9Q=; b=C3GJIDQGslnorSWDWa5i2gwcgNBzEp0Jgk40FJAeij4Aip4yQAamN00ZQ
        Gc0Un6iqltlh6fjpMi0gImeNV8kBU19FdJzZsf91/HPVzaH1P+6dLkEy/1izp2XA
        S6RDoxPE6siCLfnegDTZDfAIqfKF7IsEVyKlc4D09sXJs7GVO/17NtphnSnyjahW
        nmRppLhg0PfGn5YvvbWUQTE/8eoVO94lGLqmmEUvWLG4t3lSyvNAsF36Kf9IJdCI
        dtuyW1XrugWv6B/dL1ZwL6H9F5WdBuzB8YJvGwfaUCtds1WZr8FcSofnbu6LPWVb
        7UPiDWiS3PL0vXLDkwaAMcSpU/scQ==
X-ME-Sender: <xms:ga7mX6KtjqNIfbsceyfNO4EGWPu8ii5LOlzGw006rbkZIe6Nn_jVXw>
    <xme:ga7mXyKWDakWma44OKf9qflzV6i1In9jzCP2LgQhY5KGsUszMgQaeDFTQoDsueFG_
    KGyiGmaCKtKD3x2mEo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdduvddgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthekredttdeftfenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeejfeekffejjeekgefgvdetgeeuieevjeffheffhfffgfegvdev
    gedtgedvtdffheenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecukfhppe
    eghedrfeefrdehtddrvdehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:ga7mX6vQYwriT4Ho-jQNmnE_p-dQ6OWHGYNeXwNU5QUg546d7pjSWw>
    <xmx:ga7mX_bmgAYxza6wq0NEWeOCcZiET0NzNG9ygvHIHKNv06u5KWRpuw>
    <xmx:ga7mXxYfbw_oXe3vqcbBtn1-D2F6WYysYPufEsusUo6UUeqZi2rM9w>
    <xmx:g67mX0yGu0kJFOwq0T4uphbNUrqQfaYEVYaNrCxDprPkaxlkRsioJ7BMHls>
Received: from [0.0.0.0] (li1000-254.members.linode.com [45.33.50.254])
        by mail.messagingengine.com (Postfix) with ESMTPA id 876B124005C;
        Fri, 25 Dec 2020 22:31:10 -0500 (EST)
Subject: Re: [PATCH v4 2/4] spi: ls7a: Add YAML schemas
To:     Qing Zhang <zhangqing@loongson.cn>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        ThomasBogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-spi@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1608892552-15457-1-git-send-email-zhangqing@loongson.cn>
 <1608892552-15457-2-git-send-email-zhangqing@loongson.cn>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <7d26a91a-f463-9ae4-8420-28a1b591053b@flygoat.com>
Date:   Sat, 26 Dec 2020 11:31:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1608892552-15457-2-git-send-email-zhangqing@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

ÔÚ 2020/12/25 ÏÂÎç6:35, Qing Zhang Ð´µÀ:
> Switch the DT binding to a YAML schema to enable the DT validation.
>
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> ---
>
> v4: fix warnings/errors about running 'make dt_binding_check'
>
> ---
>   .../devicetree/bindings/spi/loongson,spi-ls7a.yaml | 46 ++++++++++++++++++++++
>   1 file changed, 46 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/spi/loongson,spi-ls7a.yaml
>
> diff --git a/Documentation/devicetree/bindings/spi/loongson,spi-ls7a.yaml b/Documentation/devicetree/bindings/spi/loongson,spi-ls7a.yaml
> new file mode 100644
> index 0000000..8cc9bc5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/loongson,spi-ls7a.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/loongson,spi-ls7a.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson LS7A PCH SPI Controller
> +
> +maintainers:
> +  - Qing Zhang <zhangqing@loongson.cn>
> +
> +description: |
> +  This controller can be found in Loongson-3 systems with LS7A PCH.
> +
> +properties:
> +  compatible:
> +    const: loongson,ls7a-spi
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - num-chipselects

num-chipselects never parsed in code?

Thanks.

- Jiaxun



> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pci {
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +
> +        spi@16,0 {
> +        compatible = "pci0014,7a0b.0",
> +                        "pci0014,7a0b",
> +                        "pciclass088000",
> +                        "pciclass0800";
> +
> +        reg = <0xb000 0x0 0x0 0x0 0x0>;
> +        num-chipselects = <0>;
> +        };
> +    };
> +
> +...

