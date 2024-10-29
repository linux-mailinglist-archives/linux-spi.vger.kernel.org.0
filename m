Return-Path: <linux-spi+bounces-5536-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BB69B54C7
	for <lists+linux-spi@lfdr.de>; Tue, 29 Oct 2024 22:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC32A2846CB
	for <lists+linux-spi@lfdr.de>; Tue, 29 Oct 2024 21:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F94207A22;
	Tue, 29 Oct 2024 21:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="2cFtcmxs"
X-Original-To: linux-spi@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038CC198E99
	for <linux-spi@vger.kernel.org>; Tue, 29 Oct 2024 21:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730236432; cv=none; b=rSS8F84pkZFpN2vpoL4dBOXzfY3UNU2Ezj4sg1y2G913hd6N6HsFC5Rkq+V0fK4Nuf5piY3WbYptoezJLfgr0p3ho/WTUH2LucGtD/VUNvPdAdJtu890Bpgkt2asEFWvGuQMxWgd9Vp8nqVbN9XMJU64zCfEk/W1XviMjmHUgN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730236432; c=relaxed/simple;
	bh=uo/toYeCSKCj5aGUF+L/LlnhwQQw9+cmfQ4mmMv8Q1I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=j5X3TEmjz58FK1Kr2o7ArChi/w8OX2ibN9N+9j8A8Wvq18MSkFwB70kLpyKh1WFsEGxDfLHGeZspGHIT/nExHT65fUGGLIf4unDM0lqPszAAW05D4WTVvAj7RimRdfvaPqii1dCyOxn2sikd44Om2DjvPA2HB6NgKXy4Jw7l7WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=2cFtcmxs; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 862932C0117;
	Wed, 30 Oct 2024 10:13:45 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1730236425;
	bh=uo/toYeCSKCj5aGUF+L/LlnhwQQw9+cmfQ4mmMv8Q1I=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=2cFtcmxsG32Pmo7RUg3YMhwhCdv57h/SY+1qDwrgj6rFYfopLCKSst3P0Jp/Jxvkl
	 lqJ44aNYAph/lCy5f6mYmYxxMEIHiDuJOnLcHO2b1OmjS1uLo5/ETcOlUvYRacTJxl
	 sVLhLKh5XnUtFFIAVjIiGyv7bfxLeA+NyCJFKuqPJl4MbE4Fa9wQH2HumzxsW0kTlf
	 J5IhrZakAC9UZdl8oxy3sWr9qs1C+SWNJzgvWLThXYSszBkH9ye1wL2qlKuWwI16Kv
	 B+E8spDI0DJIZsWvVA6Mmi+NnYGHiva4oFaan14E5Ou4X5yYLD4LsCr2F4U/tqLMQV
	 K0FAEPgVxHHYw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B672150090000>; Wed, 30 Oct 2024 10:13:45 +1300
Received: from [10.33.22.30] (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 4397013ED6B;
	Wed, 30 Oct 2024 10:13:45 +1300 (NZDT)
Message-ID: <94ffb58b-3242-4ab4-b09a-686116ced781@alliedtelesis.co.nz>
Date: Wed, 30 Oct 2024 10:13:45 +1300
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: ubifs_recover_master_node: failed to recover master node
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <826c4456-461c-424b-88de-a36e77fd7475@alliedtelesis.co.nz>
Content-Language: en-US
In-Reply-To: <826c4456-461c-424b-88de-a36e77fd7475@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=67215009 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=ZsQRNL2YhwNOoF4Hqy8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat


On 29/10/24 13:38, Chris Packham wrote:
> (resend as plaintext)
>
> Hi,
>
> I recently added support for the SPI-NAND controller on the RTL9302C=20
> SoC[1]. I did most of the work against Linux 6.11 and it's working=20
> fine there. I recently rebased against the tip of Linus's tree=20
> (6.12-rc5) and found I was getting ubifs errors when mounting:
>
> [=C2=A0=C2=A0=C2=A0 1.255191] spi-nand spi1.0: Macronix SPI NAND was fo=
und.
> [=C2=A0=C2=A0=C2=A0 1.261283] spi-nand spi1.0: 256 MiB, block size: 128=
 KiB, page=20
> size: 2048, OOB size: 64
> [=C2=A0=C2=A0=C2=A0 1.271134] 2 fixed-partitions partitions found on MT=
D device spi1.0
> [=C2=A0=C2=A0=C2=A0 1.278247] Creating 2 MTD partitions on "spi1.0":
> [=C2=A0=C2=A0=C2=A0 1.283631] 0x000000000000-0x00000f000000 : "user"
> [=C2=A0=C2=A0 20.481108] 0x00000f000000-0x000010000000 : "Reserved"
> [=C2=A0=C2=A0 72.240347] ubi0: scanning is finished
> [=C2=A0=C2=A0 72.270577] ubi0: attached mtd3 (name "user", size 240 MiB=
)
> [=C2=A0=C2=A0 72.276815] ubi0: PEB size: 131072 bytes (128 KiB), LEB si=
ze:=20
> 126976 bytes
> [=C2=A0=C2=A0 72.284537] ubi0: min./max. I/O unit sizes: 2048/2048, sub=
-page=20
> size 2048
> [=C2=A0=C2=A0 72.292132] ubi0: VID header offset: 2048 (aligned 2048), =
data=20
> offset: 4096
> [=C2=A0=C2=A0 72.299885] ubi0: good PEBs: 1920, bad PEBs: 0, corrupted =
PEBs: 0
> [=C2=A0=C2=A0 72.306689] ubi0: user volume: 1, internal volumes: 1, max=
. volumes=20
> count: 128
> [=C2=A0=C2=A0 72.314747] ubi0: max/mean erase counter: 1/0, WL threshol=
d: 4096,=20
> image sequence number: 252642230
> [=C2=A0=C2=A0 72.324850] ubi0: available PEBs: 0, total reserved PEBs: =
1920,=20
> PEBs reserved for bad PEB handling: 40
> [=C2=A0=C2=A0 72.370123] ubi0: background thread "ubi_bgt0d" started, P=
ID 141
> [=C2=A0=C2=A0 72.470740] UBIFS (ubi0:0): Mounting in unauthenticated mo=
de
> [=C2=A0=C2=A0 72.490246] UBIFS (ubi0:0): background thread "ubifs_bgt0_=
0"=20
> started, PID 144
> [=C2=A0=C2=A0 72.528272] UBIFS error (ubi0:0 pid 143):=20
> ubifs_recover_master_node: failed to recover master node
> [=C2=A0=C2=A0 72.550122] UBIFS (ubi0:0): background thread "ubifs_bgt0_=
0" stops
> [=C2=A0=C2=A0 72.710720] UBIFS (ubi0:0): Mounting in unauthenticated mo=
de
> [=C2=A0=C2=A0 72.717447] UBIFS (ubi0:0): background thread "ubifs_bgt0_=
0"=20
> started, PID 149
> [=C2=A0=C2=A0 72.777602] UBIFS error (ubi0:0 pid 148):=20
> ubifs_recover_master_node: failed to recover master node
> [=C2=A0=C2=A0 72.787792] UBIFS (ubi0:0): background thread "ubifs_bgt0_=
0" stops
>
> Full dmesg output is at[2]
>
> git bisect lead me to commit 11813857864f ("mtd: spi-nand: macronix:=20
> Continuous read support"). Reverting the blamed commit from 6.12-rc5=20
> seems to avoid the problem. The flash chip on my board is a=20
> MX30LF2G28AD-TI. I'm not sure if there is a problem with 11813857864f=20
> or with my spi-mem driver that is exposed after support for continuous=20
> read is enabled.
>
A bit of an update. The ubifs failure is from the is_empty() check in=20
get_master_node(). It looks like portions of the LEB are 0 instead of=20
0xff. I've also found if I avoid use the non-DMA path in my driver I=20
don't have such a problem. I think there is at least one problem in my=20
driver because I don't handle DMAing more than 0xffff bytes.


> Thanks,
> Chris
>
> --=20
>
> [1] -=20
> https://lore.kernel.org/all/20241015225434.3970360-1-chris.packham@alli=
edtelesis.co.nz/
> [2] -=20
> https://gist.github.com/cpackham-atlnz/66a0843362e8f8eb2c4f5c7ed01c5efe
>

