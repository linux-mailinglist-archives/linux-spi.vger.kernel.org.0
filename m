Return-Path: <linux-spi+bounces-10394-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D60BB02E3
	for <lists+linux-spi@lfdr.de>; Wed, 01 Oct 2025 13:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D974A7D5E
	for <lists+linux-spi@lfdr.de>; Wed,  1 Oct 2025 11:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9414B2DA77F;
	Wed,  1 Oct 2025 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VEshQX2R"
X-Original-To: linux-spi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E752D879F;
	Wed,  1 Oct 2025 11:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759318455; cv=none; b=Rn9NUT74EQqbnKjuiWMT19HqisHxnTXHpBk0FkdsqirOdPpSeU6Aro8QC8GS3YqOi0B3yUsC6ciW0KaQkDP69P9ls7dHHAtpfXP+87zVHjJGDDcBL8SHXxXMsHdWyGhu8qPEIqzRlQL1cD31jc3TTAJn5zDlxJOHVpcQrnuyEg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759318455; c=relaxed/simple;
	bh=OkY4fp2SjExYLRU7K7uU8FjXdXwmHdXuDmYve9vU6oU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pN2ODpmG5hZxwZOJeh4Gmuj8oqLqQVY2jcXFKPJCUsmMu7dYHPKJGaJXkM3oTD0IPF2mIOX6yNuxluoSjahePqCyGYicjtQqOPURCvmBQ2hMbQ7XQM1rbyUME4QGUTaF/CSMbjNJJooUGJ9J/ZeDqVvWlVBMBF7UL6sc6KGeHnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VEshQX2R; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759318452;
	bh=OkY4fp2SjExYLRU7K7uU8FjXdXwmHdXuDmYve9vU6oU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VEshQX2RcjwMihb2A+mAF7Fr9wHa0k1sCHoINarkLYQuJMpB/vIoZA9VVzVWlKdy1
	 6RlXnI/KeF1sq33ekor4dky8MqnmeC/ZNLXQD+sgdfU7j+5ETIgNika9V6qJtb2hK9
	 fCjxfJdb+8+9P+eWAA0S4PcUfmp5palkZABWJCC3B1ySBFQz6AGtegi8sgVTr/HlER
	 LgZGGlDJWE/cjJMCh46rVWD4ozI2ZFu0z2Qj0ec60t+v9EUX+3pCdye6sigJA79Qu5
	 QRa7wvpp83XDdyOL/OgoNCvPFugtdPnSXlGf4TUZ4RFVWbJI/Pfc7S1yCSlPewoZps
	 Qv9uxb4Lmvg5A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D80FB17E13D3;
	Wed,  1 Oct 2025 13:34:11 +0200 (CEST)
Message-ID: <f5e10c75-9263-416d-a3de-32af4bb7c2dc@collabora.com>
Date: Wed, 1 Oct 2025 13:34:11 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 06/13] spi: airoha: fix reading/writing of
 flashes with more than one plane per lun
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
 Mark Brown <broonie@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Andreas Gnau <andreas.gnau@iopsys.eu>
References: <20250930022658.1485767-1-mikhail.kshevetskiy@iopsys.eu>
 <20250930022658.1485767-7-mikhail.kshevetskiy@iopsys.eu>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250930022658.1485767-7-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/09/25 04:26, Mikhail Kshevetskiy ha scritto:
> Attaching UBI on the flash with more than one plane per lun will lead to
> the following error:
> 
> [    2.980989] spi-nand spi0.0: Micron SPI NAND was found.
> [    2.986309] spi-nand spi0.0: 256 MiB, block size: 128 KiB, page size: 2048, OOB size: 128
> [    2.994978] 2 fixed-partitions partitions found on MTD device spi0.0
> [    3.001350] Creating 2 MTD partitions on "spi0.0":
> [    3.006159] 0x000000000000-0x000000020000 : "bl2"
> [    3.011663] 0x000000020000-0x000010000000 : "ubi"
> ...
> [    6.391748] ubi0: attaching mtd1
> [    6.412545] ubi0 error: ubi_attach: PEB 0 contains corrupted VID header, and the data does not contain all 0xFF
> [    6.422677] ubi0 error: ubi_attach: this may be a non-UBI PEB or a severe VID header corruption which requires manual inspection
> [    6.434249] Volume identifier header dump:
> [    6.438349]     magic     55424923
> [    6.441482]     version   1
> [    6.444007]     vol_type  0
> [    6.446539]     copy_flag 0
> [    6.449068]     compat    0
> [    6.451594]     vol_id    0
> [    6.454120]     lnum      1
> [    6.456651]     data_size 4096
> [    6.459442]     used_ebs  1061644134
> [    6.462748]     data_pad  0
> [    6.465274]     sqnum     0
> [    6.467805]     hdr_crc   61169820
> [    6.470943] Volume identifier header hexdump:
> [    6.475308] hexdump of PEB 0 offset 4096, length 126976
> [    6.507391] ubi0 warning: ubi_attach: valid VID header but corrupted EC header at PEB 4
> [    6.515415] ubi0 error: ubi_compare_lebs: unsupported on-flash UBI format
> [    6.522222] ubi0 error: ubi_attach_mtd_dev: failed to attach mtd1, error -22
> [    6.529294] UBI error: cannot attach mtd1
> 
> Non dirmap reading works good. Looking to spi_mem_no_dirmap_read() code we'll see:
> 
> 	static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
> 					      u64 offs, size_t len, void *buf)
> 	{
> 		struct spi_mem_op op = desc->info.op_tmpl;
> 		int ret;
> 
> // --- see here ---
> 		op.addr.val = desc->info.offset + offs;
> //-----------------
> 		op.data.buf.in = buf;
> 		op.data.nbytes = len;
> 		ret = spi_mem_adjust_op_size(desc->mem, &op);
> 		if (ret)
> 		return ret;
> 
> 		ret = spi_mem_exec_op(desc->mem, &op);
> 		if (ret)
> 			return ret;
> 
> 		return op.data.nbytes;
> 	}
> 
> The similar happens for spi_mem_no_dirmap_write(). Thus the address
> passed to the flash should take in the account the value of
> desc->info.offset.
> 
> This patch fix dirmap reading/writing of flashes with more than one
> plane per lun.
> 
> Fixes: a403997c12019 ("spi: airoha: add SPI-NAND Flash controller driver")
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



