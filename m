Return-Path: <linux-spi+bounces-5530-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1FC9B3F42
	for <lists+linux-spi@lfdr.de>; Tue, 29 Oct 2024 01:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6345B21BC0
	for <lists+linux-spi@lfdr.de>; Tue, 29 Oct 2024 00:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E676C8C7;
	Tue, 29 Oct 2024 00:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="w96pig3m"
X-Original-To: linux-spi@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C51FBF0
	for <linux-spi@vger.kernel.org>; Tue, 29 Oct 2024 00:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730162333; cv=none; b=rIFYHou8OuCTSez0+CcgLtqhx8+4gAorZ1HkkoT0Klm73qYg8gSIKQjzBUJ+0YeGU+8p7nwrLW/tgK47WUlIGLWR+OwuvU6gWe+arCBtR3wZlzkBmrCqDqoKRIuIPAufqnXMHdVv8ZGLLvZQiwnBIH9axTMS3CUpCPFIMQt5JWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730162333; c=relaxed/simple;
	bh=1TRrFEU/XYzXbAArtmSSYVFHq0PJWrAZw/PZ69nzIRg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=k7jR9Z5XwvLaV9tLa2MMYORSJsAy6RyshgrnkmaJnFAt5Ok5wBb8rQGNbyrec4dTXwfuQL3iAPNS6qoDJldze/rFI70JEh4PsSZeHByzS6sPYh45iK68byx6sZcCt9wAZjsj6m/wXj6VtMtaJVLTLf/tGZ3JRL+xGMujV+XKoD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=w96pig3m; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 4F17E2C0707;
	Tue, 29 Oct 2024 13:38:47 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1730162327;
	bh=1TRrFEU/XYzXbAArtmSSYVFHq0PJWrAZw/PZ69nzIRg=;
	h=Date:From:Subject:To:Cc:From;
	b=w96pig3mG/5eekKbdvyYIJjYAO9Dkz4BeKrLBo2JyCQYgXS6u2qKn81MYGol6VPGs
	 d0NHhw6l6gUMjNuh9BJuSYuLi3IaDDogxKOmuWXYrVS/FMNqgg2TSrzr/xhRi0bj7P
	 G7OeBSh/C5CMazx14Y2S0Jt7c55RhBDQiOOXCZja7Gd59ysAsTDF1Uxw6h7oMmC2Vr
	 JQhIIRYOIonn38fcv6YhCEf9Y1w/gzTI0YOhMy6Wd0eNykV2VlaegdJk/oYh4uXcAs
	 TP2/K4fkmV1eOE8STBcHja2TuTK7zIogbrEeoF5do2HNeDfQdQplkTly9ufhl3GiWt
	 0HUQ+6XN3RmIw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B67202e970000>; Tue, 29 Oct 2024 13:38:47 +1300
Received: from [10.33.22.30] (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 3FA9F13ED7B;
	Tue, 29 Oct 2024 13:38:47 +1300 (NZDT)
Message-ID: <826c4456-461c-424b-88de-a36e77fd7475@alliedtelesis.co.nz>
Date: Tue, 29 Oct 2024 13:38:47 +1300
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: ubifs_recover_master_node: failed to recover master node
To: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=67202e97 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=D-m8bwV1JRgZdnQgOdUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

(resend as plaintext)

Hi,

I recently added support for the SPI-NAND controller on the RTL9302C=20
SoC[1]. I did most of the work against Linux 6.11 and it's working fine=20
there. I recently rebased against the tip of Linus's tree (6.12-rc5) and=20
found I was getting ubifs errors when mounting:

[=C2=A0=C2=A0=C2=A0 1.255191] spi-nand spi1.0: Macronix SPI NAND was foun=
d.
[=C2=A0=C2=A0=C2=A0 1.261283] spi-nand spi1.0: 256 MiB, block size: 128 K=
iB, page size:=20
2048, OOB size: 64
[=C2=A0=C2=A0=C2=A0 1.271134] 2 fixed-partitions partitions found on MTD =
device spi1.0
[=C2=A0=C2=A0=C2=A0 1.278247] Creating 2 MTD partitions on "spi1.0":
[=C2=A0=C2=A0=C2=A0 1.283631] 0x000000000000-0x00000f000000 : "user"
[=C2=A0=C2=A0 20.481108] 0x00000f000000-0x000010000000 : "Reserved"
[=C2=A0=C2=A0 72.240347] ubi0: scanning is finished
[=C2=A0=C2=A0 72.270577] ubi0: attached mtd3 (name "user", size 240 MiB)
[=C2=A0=C2=A0 72.276815] ubi0: PEB size: 131072 bytes (128 KiB), LEB size=
: 126976=20
bytes
[=C2=A0=C2=A0 72.284537] ubi0: min./max. I/O unit sizes: 2048/2048, sub-p=
age size 2048
[=C2=A0=C2=A0 72.292132] ubi0: VID header offset: 2048 (aligned 2048), da=
ta=20
offset: 4096
[=C2=A0=C2=A0 72.299885] ubi0: good PEBs: 1920, bad PEBs: 0, corrupted PE=
Bs: 0
[=C2=A0=C2=A0 72.306689] ubi0: user volume: 1, internal volumes: 1, max. =
volumes=20
count: 128
[=C2=A0=C2=A0 72.314747] ubi0: max/mean erase counter: 1/0, WL threshold:=
 4096,=20
image sequence number: 252642230
[=C2=A0=C2=A0 72.324850] ubi0: available PEBs: 0, total reserved PEBs: 19=
20, PEBs=20
reserved for bad PEB handling: 40
[=C2=A0=C2=A0 72.370123] ubi0: background thread "ubi_bgt0d" started, PID=
 141
[=C2=A0=C2=A0 72.470740] UBIFS (ubi0:0): Mounting in unauthenticated mode
[=C2=A0=C2=A0 72.490246] UBIFS (ubi0:0): background thread "ubifs_bgt0_0"=
 started,=20
PID 144
[=C2=A0=C2=A0 72.528272] UBIFS error (ubi0:0 pid 143): ubifs_recover_mast=
er_node:=20
failed to recover master node
[=C2=A0=C2=A0 72.550122] UBIFS (ubi0:0): background thread "ubifs_bgt0_0"=
 stops
[=C2=A0=C2=A0 72.710720] UBIFS (ubi0:0): Mounting in unauthenticated mode
[=C2=A0=C2=A0 72.717447] UBIFS (ubi0:0): background thread "ubifs_bgt0_0"=
 started,=20
PID 149
[=C2=A0=C2=A0 72.777602] UBIFS error (ubi0:0 pid 148): ubifs_recover_mast=
er_node:=20
failed to recover master node
[=C2=A0=C2=A0 72.787792] UBIFS (ubi0:0): background thread "ubifs_bgt0_0"=
 stops

Full dmesg output is at[2]

git bisect lead me to commit 11813857864f ("mtd: spi-nand: macronix:=20
Continuous read support"). Reverting the blamed commit from 6.12-rc5=20
seems to avoid the problem. The flash chip on my board is a=20
MX30LF2G28AD-TI. I'm not sure if there is a problem with 11813857864f or=20
with my spi-mem driver that is exposed after support for continuous read=20
is enabled.

Thanks,
Chris

--

[1] -=20
https://lore.kernel.org/all/20241015225434.3970360-1-chris.packham@allied=
telesis.co.nz/
[2] -=20
https://gist.github.com/cpackham-atlnz/66a0843362e8f8eb2c4f5c7ed01c5efe


