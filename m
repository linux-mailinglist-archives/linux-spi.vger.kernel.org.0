Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22782D266D
	for <lists+linux-spi@lfdr.de>; Tue,  8 Dec 2020 09:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgLHIlA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Dec 2020 03:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgLHIlA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Dec 2020 03:41:00 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3C7C061793;
        Tue,  8 Dec 2020 00:40:19 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id q8so18120476ljc.12;
        Tue, 08 Dec 2020 00:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hVOWo+pBoZR2uZ3E/0eQOGPjxtsx6mvaLfulHDkgAOU=;
        b=Mx72BqfualNQHZXc9k9tHobfNsjEXoO7+T0DfnJ/+r4Dn9bsth98VA+BNxG0x0EEvi
         wp5vpv7YllmzEWTXRQT5D9qRc8vx4NkPC8hHOfcanETZU4YyTfwBv78fYz56462upoQQ
         tnESm3QFQdXw91cn9gS9qLM/ZxfS8dYfh5hctndNaSO6lp67Hoy5dvB31pHKg0d5JUC3
         jwXvw6/KC1Yt38SqHDK1WWO9JxnTCZn7czaZX0k4eJlmNwShQNW/yX3SyNXPl1YF5jgS
         ug+9LS1K3O6bBYuYmZ3fa6LycSXadzu8gLoBY179cxQT7WcLqV0u9xjGki9HEVcEzTum
         xCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hVOWo+pBoZR2uZ3E/0eQOGPjxtsx6mvaLfulHDkgAOU=;
        b=V4LHAgTQgdWdGrJc8t/n9liuO9SvuNkrmrgC7K8RHqDW8UuoPe1Zu3wsFEi+ihzVk0
         +CzoEMh/gLLmk8tU63xhnk3Xm3wEQaKUBqkBQyooSPZftldU1xEnCcTDuzXjbotGMPiD
         jcIjOs7Z10hKlhcFgutg9s0E9w8eDzoZkJcsl+mhbwdsvUOWBQFfV4VEEXCU3gTuktFO
         X+tPTSwZJkjiFRMmiOGY3TgkMJxvjj4EenF0s/EyQaP4gePBinQrqHEea3S/YBpLpzYd
         Kv1DFzKc1ytN8r/0USm5Gg9yhn84o1a+vj/ivCJn4xiZ5LJos+dqRdX2uPlL3sxUD/ma
         h/Yw==
X-Gm-Message-State: AOAM531eklrf/ctuckcLwdSDPp4O+e7SFHNPe+EcNTlF2Q1cY8WqMfz9
        EGDLSZ1FqHELOYJxPZBmIzQ=
X-Google-Smtp-Source: ABdhPJw+4gdhHVe4TOvyC/W1Zeq5hBs7zZf1xnBizkrqoJ79TIdVD/bLFBRXvQknE/0mB/JixMMWrA==
X-Received: by 2002:a2e:90c5:: with SMTP id o5mr10454961ljg.136.1607416818275;
        Tue, 08 Dec 2020 00:40:18 -0800 (PST)
Received: from [192.168.1.100] ([178.176.72.18])
        by smtp.gmail.com with ESMTPSA id 8sm3163520lfk.246.2020.12.08.00.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 00:40:17 -0800 (PST)
Subject: Re: [PATCH v2 2/4] spi: Add devicetree bindings documentation for
 Loongson SPI
To:     Qing Zhang <zhangqing@loongson.cn>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-spi@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaojuxin@loongson.cn,
        yangtiezhu@loongson.cn
References: <1607413467-17698-1-git-send-email-zhangqing@loongson.cn>
 <1607413467-17698-2-git-send-email-zhangqing@loongson.cn>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <b97c4d59-3279-f67d-d951-1e9436faa640@gmail.com>
Date:   Tue, 8 Dec 2020 11:40:07 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <1607413467-17698-2-git-send-email-zhangqing@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello!

On 08.12.2020 10:44, Qing Zhang wrote:

> Add spi-ls7a binding documentation.
> 
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> ---
>   Documentation/devicetree/bindings/spi/spi-ls7a.txt | 31 ++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/spi/spi-ls7a.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-ls7a.txt b/Documentation/devicetree/bindings/spi/spi-ls7a.txt
> new file mode 100644
> index 0000000..56247b5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-ls7a.txt
> @@ -0,0 +1,31 @@
> +Binding for LOONGSON LS7A SPI controller
> +
> +Required properties:
> +- compatible: should be "pci0014,7a0b.0","pci0014,7a0b","pciclass088000","pciclass0880".
> +- reg: reference IEEE Std 1275-1994.
> +- #address-cells: <1>, as required by generic SPI binding.
> +- #size-cells: <0>, also as required by generic SPI binding.
> +- #interrupts: No hardware interrupt.

    You say it's a required prop, yet yuoe example doesn't have it...

> +
> +Child nodes as per the generic SPI binding.
> +
> +Example:
> +
> +			spi@16,0 {
> +				compatible = "pci0014,7a0b.0",
> +						"pci0014,7a0b",
> +						"pciclass088000",
> +						"pciclass0880";
> +
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <0xb000 0x0 0x0 0x0 0x0>;
> +				num-chipselects = <0>;
> +				spiflash: s25fl016k@0 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;

    Once more?

> +				compatible ="spansion,s25fl016k","jedec,spi-nor";

    Once more?

> +				spi-max-frequency=<50000000>;
> +				reg=<0>;

    Once more? Did you mean this for a child node?

> +				};
> +			};

MBR, Sergei
