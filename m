Return-Path: <linux-spi+bounces-10181-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D802B8BDC2
	for <lists+linux-spi@lfdr.de>; Sat, 20 Sep 2025 04:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AF9C1C02D9F
	for <lists+linux-spi@lfdr.de>; Sat, 20 Sep 2025 02:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C161EE033;
	Sat, 20 Sep 2025 02:58:42 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1085A10F1;
	Sat, 20 Sep 2025 02:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758337122; cv=none; b=K9Q4TGZnGNhhIr6yXs8Xb6uy9uVikJE6xbzETfBvxqZFiyvEU7L5/piVJtqqFktOaz7p35GcLvjehTQ5XQ1V/oOcE9Aiwuqepxnr/yam1EAv5Gz0xlsBZiDrBEcMD0ukLg1CIOjymC9ydEpgkFfUUX+5yzdK740nSKnXq70tSwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758337122; c=relaxed/simple;
	bh=BNOcrsPtGVCnjoHd0bfmpLA8vi4nFc9VnR7K2gZeWzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GO6GA7biqN8bc0oWvRzc1Czl7sdHfJIByieV5H76+17ZtWoxUddj7/ZON24+SWarW2o7iyvL0GvC9DhsN4yywiGcBATuKNlR5Pb6kh2Br47Osl7JohGda4YPi8dFBJmk/xSlSg1aPSYy1fisRRQ04mXrWr6zR/yvvZqzNOCOW4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.102] (unknown [114.241.87.235])
	by APP-03 (Coremail) with SMTP id rQCowACX54EzGM5obAbXAw--.5582S2;
	Sat, 20 Sep 2025 10:57:55 +0800 (CST)
Message-ID: <50456256-fc9e-4de5-a512-5749b832dc3a@iscas.ac.cn>
Date: Sat, 20 Sep 2025 10:57:55 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] riscv: dts: spacemit: define a SPI controller node
To: Alex Elder <elder@riscstar.com>, broonie@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dlan@gentoo.org, ziyao@disroot.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250919155914.935608-1-elder@riscstar.com>
 <20250919155914.935608-4-elder@riscstar.com>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20250919155914.935608-4-elder@riscstar.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:rQCowACX54EzGM5obAbXAw--.5582S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw4xCw1xZFy3WF13Wr13CFg_yoWDtFb_G3
	ZruayIganrCFnrWFyDWw1ftr40vrs2krWrtwn7Gry7Gan5Wr1kGa18Ja15Ar4UGr1aqr93
	Ca15tF4kJwsFkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbV8YjsxI4VWkCwAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xK
	xwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07jDKsUUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

On 9/19/25 23:59, Alex Elder wrote:

> [...]
>
> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
> index 6cdcd80a7c83b..f8c37d16968e4 100644
> --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> @@ -856,6 +856,22 @@ storage-bus {
>  			#size-cells = <2>;
>  			dma-ranges = <0x0 0x00000000 0x0 0x00000000 0x0 0x80000000>;
>  
> +			spi3: spi@d401c000 {
> +				compatible = "spacemit,k1-spi";
> +				reg = <0x0 0xd401c000 0x0 0x30>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				clocks = <&syscon_apbc CLK_SSP3>,
> +					 <&syscon_apbc CLK_SSP3_BUS>;
> +				clock-names = "core", "bus";
> +				resets = <&syscon_apbc RESET_SSP3>;
> +				interrupts = <55>;
> +				dmas = <&pdma 20>,
> +				       <&pdma 19>;
> +				dma-names = "rx", "tx";
> +				status = "disabled";
> +			};
> +

Is storage-bus the right place for SPI? I'd have thought that SPI
wouldn't need its own dma-ranges if it does DMA though &pdma.

I know "dram_range4" is where SpacemiT put it but I'm not sure if that
makes sense now.

Vivian "dramforever" Wang


