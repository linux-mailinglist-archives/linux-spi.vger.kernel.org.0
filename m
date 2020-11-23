Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07032C03A6
	for <lists+linux-spi@lfdr.de>; Mon, 23 Nov 2020 11:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgKWKt1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 Nov 2020 05:49:27 -0500
Received: from relay-us1.mymailcheap.com ([51.81.35.219]:45666 "EHLO
        relay-us1.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbgKWKt0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 23 Nov 2020 05:49:26 -0500
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
        by relay-us1.mymailcheap.com (Postfix) with ESMTPS id E0D9B20E92;
        Mon, 23 Nov 2020 10:49:24 +0000 (UTC)
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [144.217.248.102])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 5BFD6260EB;
        Mon, 23 Nov 2020 10:49:20 +0000 (UTC)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay1.mymailcheap.com (Postfix) with ESMTPS id 4FBC13F1C5;
        Mon, 23 Nov 2020 10:49:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id 355132A3E1;
        Mon, 23 Nov 2020 05:49:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1606128558;
        bh=Ie7rzoJQCjwB5Or+bKi9/xV3Pf6HEUgwzJivbfNLlEY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UlnRBCp+NUvxtnU3k9XFOAH1sDiBBmInfyUUbBw5vYmFC40N/F44gJgKeKuQHgvT9
         4/lgcVHVgJiKOqYTI0A8nHNsJRmFwa3RFdFbtkYqmvym+NmNjyBFkyGf+NyzYGIOLA
         biQJ7U1hKvX1/E139kwhlm8GHmOVp9fJITKkiolI=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CiMMwUKtPOFK; Mon, 23 Nov 2020 05:49:14 -0500 (EST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Mon, 23 Nov 2020 05:49:14 -0500 (EST)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 5AD40400C1;
        Mon, 23 Nov 2020 10:49:13 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="Gsi8kQTc";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [192.168.1.203] (unknown [183.157.63.183])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id D21A7400C1;
        Mon, 23 Nov 2020 10:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com;
        s=default; t=1606128544;
        bh=Ie7rzoJQCjwB5Or+bKi9/xV3Pf6HEUgwzJivbfNLlEY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Gsi8kQTcfNik76wElxof20Ymx/GUnnjGakbU074HlMUcxR3WrIZnGHh4l+rSlVuE4
         mXY8T/XRXITh9FFAmMqMCXlReAWuvyQwVDPQfhkN0OccpJR/XnVuWMSejCUl0oERUD
         +t2q6BWiwyEahZoCYKKm219hG66HKa8rOBWULhBE=
Subject: Re: [PATCH 2/3] MIPS: Loongson64: DTS: Add SPI support to LS3A
To:     Qing Zhang <zhangqing@loongson.cn>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-spi@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <1606123148-315-1-git-send-email-zhangqing@loongson.cn>
 <1606123148-315-2-git-send-email-zhangqing@loongson.cn>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <7e878d14-37b2-769e-400a-548a846943fe@flygoat.com>
Date:   Mon, 23 Nov 2020 18:48:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1606123148-315-2-git-send-email-zhangqing@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5AD40400C1
X-Spamd-Result: default: False [1.40 / 10.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         R_DKIM_ALLOW(0.00)[flygoat.com:s=default];
         MID_RHS_MATCH_FROM(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         R_SPF_SOFTFAIL(0.00)[~all:c];
         RECEIVED_SPAMHAUS_PBL(0.00)[183.157.63.183:received];
         ML_SERVERS(-3.10)[213.133.102.83];
         DKIM_TRACE(0.00)[flygoat.com:+];
         DMARC_POLICY_ALLOW(0.00)[flygoat.com,none];
         RCPT_COUNT_TWELVE(0.00)[12];
         DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[];
         HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1]
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


ÔÚ 2020/11/23 17:19, Qing Zhang Ð´µÀ:
> The LS3A SPI module is now supported, enable it.
>
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> ---
>   arch/mips/boot/dts/loongson/loongson64c-package.dtsi | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/arch/mips/boot/dts/loongson/loongson64c-package.dtsi b/arch/mips/boot/dts/loongson/loongson64c-package.dtsi
> index 5bb876a..2025c5a 100644
> --- a/arch/mips/boot/dts/loongson/loongson64c-package.dtsi
> +++ b/arch/mips/boot/dts/loongson/loongson64c-package.dtsi
> @@ -60,5 +60,12 @@
>   			interrupt-parent = <&liointc>;
>   			no-loopback-test;
>   		};
> +
> +                spi: spi@1fe00220 {
> +                        compatible = "loongson,loongson-spi";

You have to add dt schema document..

Also I'd sugguest you to name it as loongson,pci-spi to avoid collision.

Loongson-1 MCUs do have MMIO SPI controller with similiar register layout.

Thanks

- Jiaxun

> +                        reg=<0 0x1fe00220 0x11>;
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +               };
>   	};
>   };
