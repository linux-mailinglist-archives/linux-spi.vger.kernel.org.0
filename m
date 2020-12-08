Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345A82D24F7
	for <lists+linux-spi@lfdr.de>; Tue,  8 Dec 2020 08:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbgLHHw5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Dec 2020 02:52:57 -0500
Received: from relay-us1.mymailcheap.com ([51.81.35.219]:41640 "EHLO
        relay-us1.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbgLHHw4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Dec 2020 02:52:56 -0500
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
        by relay-us1.mymailcheap.com (Postfix) with ESMTPS id 3B45320F11;
        Tue,  8 Dec 2020 07:52:15 +0000 (UTC)
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.80.156])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id E327E20100;
        Tue,  8 Dec 2020 07:51:19 +0000 (UTC)
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay4.mymailcheap.com (Postfix) with ESMTPS id 1A0023F1D0;
        Tue,  8 Dec 2020 08:49:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id D9C2D2A7F1;
        Tue,  8 Dec 2020 08:49:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1607413786;
        bh=JZof9qQHNFT4gI7ChhNobeluIv2uP5Y/HEdycQ/dlzY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=b24BNqmvE0YHmJitEOII0L2qp195U0pNjLNF0H2t0dMblIJ6H0WeLSkLmrnxGPUNc
         2FERPKSiEwDR9nsNhEmBheAt01ZcuOln4/wAUlbCcl9S/Mh7Cl7j1IcQsKDO1P0K5G
         6RAfSIqEkqAw1DqQV8imiEnqh3wI81uJSUCwGdXY=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EZiM9saSC9Rn; Tue,  8 Dec 2020 08:49:43 +0100 (CET)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Tue,  8 Dec 2020 08:49:43 +0100 (CET)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id D2AF740FB8;
        Tue,  8 Dec 2020 07:49:42 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="NO1FkVgL";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [192.168.43.15] (unknown [101.84.78.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id D641C40FB8;
        Tue,  8 Dec 2020 07:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com;
        s=default; t=1607413775;
        bh=JZof9qQHNFT4gI7ChhNobeluIv2uP5Y/HEdycQ/dlzY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NO1FkVgL8kpbyPDmUU9R89ezl7y8rp2vFnHQJQWf4Cl3fZ//zVsCeHOihlVaLqAJu
         jQdPch86wkgnjDn1XGhbxGskSBPLK0YYJ7Xp6XoeE61i+FiLb2hIBi5H0UES17VyXz
         /SoV6mAyaq5a3+v+jfMnBynXAWaoxLgKCKThk3vQ=
Subject: Re: [PATCH v2 2/4] spi: Add devicetree bindings documentation for
 Loongson SPI
To:     Qing Zhang <zhangqing@loongson.cn>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-spi@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaojuxin@loongson.cn,
        yangtiezhu@loongson.cn
References: <1607413467-17698-1-git-send-email-zhangqing@loongson.cn>
 <1607413467-17698-2-git-send-email-zhangqing@loongson.cn>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <0d5e0995-8d5b-199b-4194-87567f0fd5a8@flygoat.com>
Date:   Tue, 8 Dec 2020 15:49:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <1607413467-17698-2-git-send-email-zhangqing@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D2AF740FB8
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
> Add spi-ls7a binding documentation.
>
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> ---
>   Documentation/devicetree/bindings/spi/spi-ls7a.txt | 31 ++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/spi/spi-ls7a.txt


Hi Qing,

Please use dt schema instead.

Thanks.

- Jiaxun


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
> +				compatible ="spansion,s25fl016k","jedec,spi-nor";
> +				spi-max-frequency=<50000000>;
> +				reg=<0>;
> +				};
> +			};
