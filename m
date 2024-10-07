Return-Path: <linux-spi+bounces-5124-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8B6993771
	for <lists+linux-spi@lfdr.de>; Mon,  7 Oct 2024 21:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCDC1283360
	for <lists+linux-spi@lfdr.de>; Mon,  7 Oct 2024 19:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647871DE3A0;
	Mon,  7 Oct 2024 19:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="BIlVF+0g"
X-Original-To: linux-spi@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242781DE2B4
	for <linux-spi@vger.kernel.org>; Mon,  7 Oct 2024 19:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728329709; cv=none; b=ss2HFnzR6hYCA6fT04jjmv6P/YISm/UzrOMJup3eBmqCFhCZzNtNhvewBmNJiNM5yRLq2di00pSN4mWHgFfvIPYNtxHpNKHTPOJe2TZJF+ntRRIfl4gJAgVYRzWImRwkWJsTKuriSJ2EcZcPyCxRVmdc+AoMgRPgY5c+qgiYGEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728329709; c=relaxed/simple;
	bh=wu0J703KOgthSaTZabA2Myy4JS7UkFiX2jdDBfTCYtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A1Kj04jQYdNQaLVYh0ngooGsc46LiqjQw1whtE9Sw6z2cZkRBmQ82WPoRTdVV0rF7Zugu/bKaKhE9WzgoDIjbTxtInSkfqsH5+/nWrbwY8PeoC1iKoBSG5247XHbCTm0d8AJW7aPM4bqigmDVvX8AAIyPOo87Y9n9gpXgSLo3sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=BIlVF+0g; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C4E112C02E1;
	Tue,  8 Oct 2024 08:35:03 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1728329703;
	bh=N3QCXddpP5MFDFrwV9sa5i+xlIBGtMBo289HWjhpDwg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BIlVF+0g/VYhqkDvNCwX3SaKrqhV9nWcM7Be6GtcV8UskCl5fqRO6WC+Phu/HF5Qh
	 ojYlhA0eLDLXTm0tyjVhN6H9n1dpNMNBKarRAFnqyJINYpIIHACN4TCWmTjmTd4Q7l
	 PNwB/36VdUS1jNv12jRp4vfED0sVWrDI+1yX34QSPNYHJlR/U6NrwR2JTxNHwv9wnM
	 5B8aUBF0EIYh7QQYHWl3Ym370btFIo1phNXinVXKmSR/fB/D4HPOyJIzwaM872kwIC
	 EKlRK+Za5ZK/b1Mma346V5dkZfQwZey4wai6vUFZxofWFXR49ilzl3ErwxuBweMZmm
	 rbPSJiyCBLmoQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B670437e70000>; Tue, 08 Oct 2024 08:35:03 +1300
Received: from [10.33.22.30] (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 97AB513ED7B;
	Tue,  8 Oct 2024 08:35:03 +1300 (NZDT)
Message-ID: <a39e9fc8-b580-4324-8ba0-63a1a51685e9@alliedtelesis.co.nz>
Date: Tue, 8 Oct 2024 08:35:03 +1300
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 3/3] spi: spi-mem: Add Realtek SPI-NAND controller
To: Mark Brown <broonie@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 tsbogend@alpha.franken.de, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org
References: <20241006233347.333586-1-chris.packham@alliedtelesis.co.nz>
 <20241006233347.333586-4-chris.packham@alliedtelesis.co.nz>
 <ZwPzav6dFQdXSnjx@finisterre.sirena.org.uk>
Content-Language: en-US
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
In-Reply-To: <ZwPzav6dFQdXSnjx@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Id0kWnqa c=1 sm=1 tr=0 ts=670437e7 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=L-1965lpuaw6YQIIu8wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat


On 8/10/24 03:42, Mark Brown wrote:
> On Mon, Oct 07, 2024 at 12:33:47PM +1300, Chris Packham wrote:
>
>> +REALTEK SPI-NAND
>> +M:	Chris Pacham <chris.packham@alliedtelesis.co.nz>
> Pacham?
Darn, that'll teach me for hurriedly going through the checkpatch warnings.
>
>> +static int rtl_snand_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
>> +{
>> +	return 0;
>> +}
>> +
> If the framework doesn't already support this callback being missing we
> should probably make it so.
The framework handles this being missing. This is just left over from 
the initial stub I created when I started. Will remove in v2.
>
> Otherwise this looks good.

