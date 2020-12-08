Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BB02D25B7
	for <lists+linux-spi@lfdr.de>; Tue,  8 Dec 2020 09:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgLHITR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Dec 2020 03:19:17 -0500
Received: from relay-us1.mymailcheap.com ([51.81.35.219]:42070 "EHLO
        relay-us1.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbgLHITR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Dec 2020 03:19:17 -0500
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
        by relay-us1.mymailcheap.com (Postfix) with ESMTPS id 1123820F13;
        Tue,  8 Dec 2020 08:18:36 +0000 (UTC)
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.199.117])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 963FD260EB;
        Tue,  8 Dec 2020 08:17:41 +0000 (UTC)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay4.mymailcheap.com (Postfix) with ESMTPS id 9722B3F1CF;
        Tue,  8 Dec 2020 09:16:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id C54C42A368;
        Tue,  8 Dec 2020 03:16:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1607415368;
        bh=Y3s1E8KKlNUWMouLDe3abdz9vmn2MrdVzMacGK09aJI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=rMEZKA3t+4B3pBvBvcc1ab6zrQh0Nfp/4YQqLkJhIsbxz6FV0I1NxiuD0Amcm4wu7
         8aZzxiF4/m2s4vcrB6p8ZEQYtNSgfcsgkbDvG6kKd73FMGq6yhLlJLsE6nhj8qBfKK
         T69GSbM0Fu2+VU2gg2SWm4yp4mNSi+zwdHvVBFkg=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fH9kEM8P7S0X; Tue,  8 Dec 2020 03:16:06 -0500 (EST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Tue,  8 Dec 2020 03:16:06 -0500 (EST)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 5B13D42374;
        Tue,  8 Dec 2020 08:16:04 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="acaYppbY";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [192.168.43.15] (unknown [101.84.78.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id C861F40FB8;
        Tue,  8 Dec 2020 08:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com;
        s=default; t=1607415356;
        bh=Y3s1E8KKlNUWMouLDe3abdz9vmn2MrdVzMacGK09aJI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=acaYppbYTeEcSChxX1H57jhJz4jsBU3QTHoLr8c4NPAxCDZgbnxe0ZW5wpIp7lqyJ
         pQDsENQm88FzaJ0WO1WshG/hRbhOnvRxZTy5S+OLTQrSE4DmOaYs2P4gOo8UOk/GLW
         YHuwmp6HeTZUq60XGf+QQSfa9ojgslK3NwYRgdFo=
Subject: Re: [PATCH v2 3/4] MIPS: Loongson64: DTS: Add SPI support to LS7A
To:     Qing Zhang <zhangqing@loongson.cn>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-spi@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaojuxin@loongson.cn,
        yangtiezhu@loongson.cn
References: <1607413467-17698-1-git-send-email-zhangqing@loongson.cn>
 <1607413467-17698-3-git-send-email-zhangqing@loongson.cn>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <c5a15af9-3eae-6141-2087-4f4394fae08b@flygoat.com>
Date:   Tue, 8 Dec 2020 16:15:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <1607413467-17698-3-git-send-email-zhangqing@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5B13D42374
X-Spamd-Result: default: False [1.40 / 10.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[flygoat.com:s=default];
         MID_RHS_MATCH_FROM(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         R_SPF_SOFTFAIL(0.00)[~all];
         RECEIVED_SPAMHAUS_PBL(0.00)[101.84.78.3:received];
         ML_SERVERS(-3.10)[213.133.102.83];
         DKIM_TRACE(0.00)[flygoat.com:+];
         DMARC_POLICY_ALLOW(0.00)[flygoat.com,none];
         RCPT_COUNT_SEVEN(0.00)[11];
         DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
         DBL_PROHIBIT(0.00)[0.0.0.0:email,0.0.0.16:email];
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


ÔÚ 2020/12/8 15:44, Qing Zhang Ð´µÀ:
> add spi and amd node support.

Hi Qing,


Thanks for your patch.

What is AMD node?

Also given that different boards may have different flash, is it a wise

idea to hardcode here?

Thanks.

- Jiaxun


>
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> ---
>
> v2:
> - Add spi about pci device DT
> ---
>   arch/mips/boot/dts/loongson/ls7a-pch.dtsi | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
> index f99a7a1..ab8836b 100644
> --- a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
> +++ b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
> @@ -405,6 +405,26 @@
>   				interrupt-map-mask = <0 0 0 0>;
>   				interrupt-map = <0 0 0 0 &pic 39 IRQ_TYPE_LEVEL_HIGH>;
>   			};
> +
> +			spi@16,0 {
> +				compatible = "pci0014,7a0b.0",
> +						"pci0014,7a0b",
> +						"pciclass088000",
> +						"pciclass0880";
> +
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				reg = <0xb000 0x0 0x0 0x0 0x0>;
> +				num-chipselects = <0>;
> +				spiflash: s25fl016k@0 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				compatible ="spansion,s25fl016k","jedec,spi-nor";
> +				spi-max-frequency=<50000000>;
> +				reg=<0>;
> +				};
> +			};
>   		};
>   
>   		isa {
