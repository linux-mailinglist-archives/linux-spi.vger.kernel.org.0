Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62CD12E2B71
	for <lists+linux-spi@lfdr.de>; Fri, 25 Dec 2020 13:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbgLYMUm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 25 Dec 2020 07:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbgLYMUm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 25 Dec 2020 07:20:42 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BD5C061573;
        Fri, 25 Dec 2020 04:20:01 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id m25so9782861lfc.11;
        Fri, 25 Dec 2020 04:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NikotG70jV13TXNsF314W0wEbJexz4D5n/k+PZhYUC8=;
        b=izB5uNyY73TR2b/1o2JN3Wac1R9e4hAoCuxwZkAa0QsyVQ+Ryo66kT61xgr+kiEoSA
         2+uyLlgux4D72idT/jhtUkkHfl9zMnk67DqqgeoCredoN/G+pcKoCleLeGcpsE76cpr/
         rwUrOkNPL6G6k/gSEjb1TWN490UdkdREgzEgyMyN5cWJM/56zz2+K05iqCwPGiEpIMLp
         0w9OO4/jkeXD6Shr0TJ9tw/SsdjL/huK9qs5TiolEgNQCrou5cHleZEX5lHbLAOfo/pM
         LMtiM4+FM9kEs1k7DOewMjrsimgmkepZoxnGoCGpeUSn6h59gKxYJMHkzZC0dLpCSlx8
         B+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NikotG70jV13TXNsF314W0wEbJexz4D5n/k+PZhYUC8=;
        b=FqJTe49+MyU9xnhVEDPwB/ru2TThESzcMn/7I9DoPstxTXynB8hAg55vPGoVCK7HaY
         +pBs12m53UAbymPNE6m5fqZhXE7L6QDXVYxXkzdn6DOXDRvejhcEUK1AN0jC47S219xE
         nRyVsNGmiExS6ElvMJGa3OKBzD/Hh4LGfu9Til0CFVdTxAERRid7PWClwt6Rv9i9qJbX
         6AWbFtw1JjBh5I0UEXNYmFFaBfpHzrowBQFM/A0mWs+gp9+yBjxEauP4RC7UkDz+5UV1
         TtBGsWTRiI/GsKidcHY/kje3YuH4Su+Li5C7vdfF5nMbNiZuE3U9INc/wy6I+gaUhaJV
         +fWw==
X-Gm-Message-State: AOAM5303b/gOzbpm7s8Fyq2K/awgD4wjKAKELsaxkPDHkGtYJHnqJM6/
        wUxGzN9ZnJjUMrzZpjGOLAtQ81WBrQ1ILA==
X-Google-Smtp-Source: ABdhPJx8zUkdiLAPi5Ra5IczX7Wdza6GkCUdYzI+Rx0SyB/axqnTm7VTcLjnQUUcZtzodklo8YajRg==
X-Received: by 2002:a2e:8113:: with SMTP id d19mr14821087ljg.303.1608898799585;
        Fri, 25 Dec 2020 04:19:59 -0800 (PST)
Received: from [192.168.1.101] ([31.173.81.155])
        by smtp.gmail.com with ESMTPSA id i18sm4533873lja.102.2020.12.25.04.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Dec 2020 04:19:59 -0800 (PST)
Subject: Re: [PATCH v4 2/4] spi: ls7a: Add YAML schemas
To:     Qing Zhang <zhangqing@loongson.cn>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        ThomasBogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-spi@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1608892552-15457-1-git-send-email-zhangqing@loongson.cn>
 <1608892552-15457-2-git-send-email-zhangqing@loongson.cn>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <99ab96cc-6169-19c2-04ef-d023d4427f55@gmail.com>
Date:   Fri, 25 Dec 2020 15:19:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1608892552-15457-2-git-send-email-zhangqing@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 12/25/20 1:35 PM, Qing Zhang wrote:

> Switch the DT binding to a YAML schema to enable the DT validation.
> 
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> ---
> 
> v4: fix warnings/errors about running 'make dt_binding_check'
> 
> ---
>  .../devicetree/bindings/spi/loongson,spi-ls7a.yaml | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/loongson,spi-ls7a.yaml
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

    The above lines after { need extra indentation level.

> +        };
> +    };
> +
> +...

MBR, Sergei
