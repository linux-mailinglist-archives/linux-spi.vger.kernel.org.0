Return-Path: <linux-spi+bounces-5270-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 762429A60DE
	for <lists+linux-spi@lfdr.de>; Mon, 21 Oct 2024 11:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 893431C21B26
	for <lists+linux-spi@lfdr.de>; Mon, 21 Oct 2024 09:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FC71E5734;
	Mon, 21 Oct 2024 09:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="qyKy2Wwd"
X-Original-To: linux-spi@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053E11E5701;
	Mon, 21 Oct 2024 09:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504696; cv=none; b=H29uN3098o3UbcD0GT43zMbxfm7GdripgJW24E000JOYJjj5EtKkclRUW9XmimjSezvxFlhAXi+sl92YPRmAfF743WImbHC9FvmrTbvnCcOCZk1jPkVGbiEE0NScFYu1imPloE6Q+1pw02EcAlRU6oZtYE6nBIfpPTNzr6YvXU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504696; c=relaxed/simple;
	bh=uCULIxbcJywiOKYZjq43UhyRV8sFKz967+OUgHE/Iu4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GE+MmO3cnkzdinbrRmb5ACXmKnvsLoTWuXpvc0J7WwkEioNqT4dgQlLCQZRNoAmHSwA00rm64dgRDSu1VxfanxuA3NacIHz/e9zS41pPAIC6R3aWXeBp56gcvihjHNcyKXurZlNAi0flRRqmGV5deSKllVIBB/bvFC/5OuFl1MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=qyKy2Wwd; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:Reply-To:Subject:From:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=mDveBoDYf4fN13vKMrP/EXZV3Nj+OeRfq74BWOg3v4w=;
	t=1729504694; x=1729936694; b=qyKy2Wwd9aQhqHsXwIu2FxrycJ+LCB7e/ouozBUWN5rs/CJ
	Lc+EYLSVqrYpih74WumIgkeLY5hP2Ji7iDyy0A5BtmuG9JcnzBES5pXPIqZJ4gFi8R/59R2UFyQLT
	kr+1AZg5zgRsXaIU16UF6x5Mxjqsq9YbCvz41I5RKTI6hu9KwqPlbu0Go2pnYccIpQAIJbd0yih2F
	MuZjezR/cPRzqDuobGTW5FdAQbCDUjWY7K1dMNFjvqAJkU80WT+qNbuxCG+LJ8rO8eXflfQHoh0bn
	HqkAwaj4fPTnmzZjT4jxtyImfjqHkbf9a3eUeE1QESKIM9/PkLR/2qr6aiBVWt9w==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1t2pAx-0001lx-3g; Mon, 21 Oct 2024 11:58:11 +0200
Message-ID: <43b6b750-3f7d-437f-a62e-ab2dba06827a@leemhuis.info>
Date: Mon, 21 Oct 2024 11:58:07 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Subject: Re: [REGRESSION] spi: cadence-quadspi: STIG mode results in timeouts
 for Micron MT25QL01 flash
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
To: Dhruva Gole <d-gole@ti.com>
Cc: Yoshitaka Ikeda <ikeda@nskint.co.jp>, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@pengutronix.de, Stefan Kerkmann <s.kerkmann@pengutronix.de>,
 regressions@lists.linux.dev, Mark Brown <broonie@kernel.org>
References: <c2cdfba1-afcc-4a77-8890-7da49c4b73c2@pengutronix.de>
Content-Language: en-US, de-DE
In-Reply-To: <c2cdfba1-afcc-4a77-8890-7da49c4b73c2@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1729504694;9b2e926e;
X-HE-SMSGID: 1t2pAx-0001lx-3g

On 14.10.24 14:43, Stefan Kerkmann wrote:
> 
> I have run into the same regression when probing a Micron MT25QL01 SPI-NOR flash
> on a Intel CycloneV platform (socfpga) as Yoshitaka Ikeda[1]. The regression
> manifests in read timeouts. Bisecting the issue tracked it down to commit
> "d403fb6e76bf8 spi: cadence-quadspi: use STIG mode for small reads".

Adding Dhruva Gole (author) and Mark Brown (committer) to the list of
recipients.

> Reverting
> the commit resolves the issue on v6.12-rc3. There are no custom patches applied,
> except for the debugging output mentioned in the linked thread.

The culprit afaics was merged for v6.3-rc1. Makes me wonder: would
reverting this now even an option to fix this in mainline, or would this
just lead to a regression for someone else?

Ciao, Thorsten

> The good case is as follows:
> 
> ```
> [    1.063171] **********spi_mem_op dump**************
> [    1.063183] addr: nbytes:0x0 , buswidth 0x0, dtr 0x0, val 0x0
> [    1.068093] cmd: nbytes:0x1 , buswidth 0x1, dtr 0x0, opcode 0x9F
> [    1.073837] data: nbytes:0x6 , buswidth 0x1, dtr 0x0, data dir 0x1
> [    1.079823] ***************************************
> [    1.086068] **********spi_mem_op dump**************
> [    1.090931] addr: nbytes:0x3 , buswidth 0x1, dtr 0x0, val 0x0
> [    1.095815] cmd: nbytes:0x1 , buswidth 0x1, dtr 0x0, opcode 0x5A
> [    1.101543] data: nbytes:0x10 , buswidth 0x1, dtr 0x0, data dir 0x1
> [    1.107547] ***************************************
> [    1.113835] **********spi_mem_op dump**************
> [    1.118695] addr: nbytes:0x3 , buswidth 0x1, dtr 0x0, val 0x10
> [    1.123573] cmd: nbytes:0x1 , buswidth 0x1, dtr 0x0, opcode 0x5A
> [    1.129395] data: nbytes:0x8 , buswidth 0x1, dtr 0x0, data dir 0x1
> [    1.135392] ***************************************
> [    1.141592] **********spi_mem_op dump**************
> [    1.146471] addr: nbytes:0x3 , buswidth 0x1, dtr 0x0, val 0x0
> [    1.151335] cmd: nbytes:0x1 , buswidth 0x1, dtr 0x0, opcode 0x5A
> [    1.157072] data: nbytes:0x88 , buswidth 0x1, dtr 0x0, data dir 0x1
> [    1.163058] ***************************************
> [    1.169341] **********spi_mem_op dump**************
> [    1.174219] addr: nbytes:0x3 , buswidth 0x1, dtr 0x0, val 0x30
> [    1.179082] cmd: nbytes:0x1 , buswidth 0x1, dtr 0x0, opcode 0x5A
> [    1.184904] data: nbytes:0x40 , buswidth 0x1, dtr 0x0, data dir 0x1
> [    1.190890] ***************************************
> [    1.197183] **********spi_mem_op dump**************
> [    1.202045] addr: nbytes:0x3 , buswidth 0x1, dtr 0x0, val 0x80
> [    1.206925] cmd: nbytes:0x1 , buswidth 0x1, dtr 0x0, opcode 0x5A
> [    1.212740] data: nbytes:0x8 , buswidth 0x1, dtr 0x0, data dir 0x1
> [    1.218736] ***************************************
> [    1.224916] **********spi_mem_op dump**************
> [    1.229776] addr: nbytes:0x0 , buswidth 0x0, dtr 0x0, val 0x0
> [    1.234649] cmd: nbytes:0x1 , buswidth 0x1, dtr 0x0, opcode 0x6
> [    1.240376] data: nbytes:0x0 , buswidth 0x0, dtr 0x0, data dir 0x0
> [    1.246283] ***************************************
> [    1.252443] **********spi_mem_op dump**************
> [    1.257314] addr: nbytes:0x0 , buswidth 0x0, dtr 0x0, val 0x0
> [    1.262176] cmd: nbytes:0x1 , buswidth 0x1, dtr 0x0, opcode 0xB7
> [    1.267917] data: nbytes:0x0 , buswidth 0x0, dtr 0x0, data dir 0x0
> [    1.273914] ***************************************
> [    1.280074] **********spi_mem_op dump**************
> [    1.284946] addr: nbytes:0x0 , buswidth 0x0, dtr 0x0, val 0x0
> [    1.289809] cmd: nbytes:0x1 , buswidth 0x1, dtr 0x0, opcode 0x4
> [    1.295544] data: nbytes:0x0 , buswidth 0x0, dtr 0x0, data dir 0x0
> [    1.301444] ***************************************
> [    1.307694] 5 fixed-partitions partitions found on MTD device ff705000.spi.0
> [    1.319593] Creating 5 MTD partitions on "ff705000.spi.0":
> [    1.325080] 0x000000000000-0x000000040000 : "preloader"
> [    1.331825] 0x000000040000-0x0000000c0000 : "bootloader"
> [    1.338645] 0x0000000c0000-0x0000000e0000 : "barebox-environment"
> [    1.346299] 0x0000000e0000-0x000000110000 : "state-storage"
> [    1.353319] 0x000000110000-0x000008000000 : "ubi"
> ```
> 
> With the STIG short read optimization enabled, the read timeouts occur:
> 
> ```
> [    0.931469] **********spi_mem_op dump**************
> [    0.931482] addr: nbytes:0x0 , buswidth 0x0, dtr 0x0, val 0x0
> [    0.936398] cmd: nbytes:0x1 , buswidth 0x1, dtr 0x0, opcode 0x9F
> [    0.942129] data: nbytes:0x6 , buswidth 0x1, dtr 0x0, data dir 0x1
> [    0.948132] ***************************************
> [    0.954369] **********spi_mem_op dump**************
> [    0.959233] addr: nbytes:0x3 , buswidth 0x1, dtr 0x0, val 0x0
> [    0.964117] cmd: nbytes:0x1 , buswidth 0x1, dtr 0x0, opcode 0x5A
> [    0.969845] data: nbytes:0x10 , buswidth 0x1, dtr 0x0, data dir 0x1
> [    0.975844] ***************************************
> [    1.482104] cadence-qspi ff705000.spi: Flash command execution timed out.
> [    1.493754] **********spi_mem_op dump**************
> [    1.493759] addr: nbytes:0x3 , buswidth 0x1, dtr 0x0, val 0x10
> [    1.498623] cmd: nbytes:0x1 , buswidth 0x1, dtr 0x0, opcode 0x5A
> [    1.504451] data: nbytes:0x8 , buswidth 0x1, dtr 0x0, data dir 0x1
> [    1.510438] ***************************************
> [    1.516611] spi-nor spi0.0: operation failed with -110
> [    2.026639] cadence-qspi ff705000.spi: Flash command execution timed out.
> [    2.033430] **********spi_mem_op dump**************
> [    2.033437] addr: nbytes:0x0 , buswidth 0x0, dtr 0x0, val 0x0
> [    2.038300] cmd: nbytes:0x1 , buswidth 0x1, dtr 0x0, opcode 0x6
> [    2.044041] data: nbytes:0x0 , buswidth 0x0, dtr 0x0, data dir 0x0
> [    2.049942] ***************************************
> [    2.056112] spi-nor spi0.0: operation failed with -110
> [    2.066110] spi-nor spi0.0: probe with driver spi-nor failed with error -110
> ```
> 
> The DT node for the flash is as follows:
> 
> ```
> &qspi {
> 	status = "okay";
> 
> 	flash0: flash@0 {
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		/* Micron MT25QL01 */
> 		compatible = "n25q00", "jedec,spi-nor";
> 		reg = <0>;	/* chip select */
> 		spi-max-frequency = <100000000>;
> 		m25p,fast-read;
> 		cdns,page-size = <256>;
> 		cdns,block-size = <16>;   /* 2^16, 64KB */
> 		cdns,read-delay = <4>;    /* delay value in read data capture register */
> 		cdns,tshsl-ns = <50>;
> 		cdns,tsd2d-ns = <50>;
> 		cdns,tchsh-ns = <4>;
> 		cdns,tslch-ns = <4>;
> 	};
> };
> ```
> 
> Regards,
> Stefan Kerkmann
> 
> [1]:
> https://lore.kernel.org/lkml/OSZPR01MB70048CE259A3D63C4179199A8B659@OSZPR01MB7004.jpnprd01.prod.outlook.com/#t
> 
> #regzbot introduced: d403fb6e76bf854ef0f7d84e797e51b9494788e0
> 

#regzbot poke

