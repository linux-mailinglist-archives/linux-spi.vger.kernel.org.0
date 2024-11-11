Return-Path: <linux-spi+bounces-5666-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A82989C3FD7
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 14:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FBDE1F21081
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 13:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC8D19CC3F;
	Mon, 11 Nov 2024 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f06MUedw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8FC19D091
	for <linux-spi@vger.kernel.org>; Mon, 11 Nov 2024 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731333047; cv=none; b=sPy7FsEbkIyCHkS5Zcgq/Qb2hKFj+T3hdQzS+L4Y5yvaxiQCg9f1cJVRELCVfof+vFsN44qtFOpuUwlvd0nWsoPwShC/x2J3FQn54IekfmhlcxtIb9wcf0Lnk2nbiS3LTbq4KIm4BjoTmMI3zwWBLD0jx1yKdyNNLmfcYoBpQN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731333047; c=relaxed/simple;
	bh=jJey9kSQDbGhyspkUDtpA8KOvRsbyXh4d6J2CCOxink=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qhSRcPBqUHoi6OfIuBMrAbfvq9HwSo4uyua8c7/Wgj3QMMRRyi5M+du8mmDTfzObvqXbKuZEAALKai+1WLmprnRS87Eg+lgGfL1DZdP+TBSi1Za1/JsqH5zIZhNCle7SCkorA6BButBnrLRLliRmyZibb9xoa/dO/X/WxOcjL94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f06MUedw; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso779847766b.1
        for <linux-spi@vger.kernel.org>; Mon, 11 Nov 2024 05:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731333044; x=1731937844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SpaD1h+qgSUegWPIErtuApILd4uPZKqBeb/+8dSEdD4=;
        b=f06MUedwhHQE2SxEszkVsV5oHjQVojfbB2VP5Y1/fN0LFbyb68ehZpwClR0yoJBAjt
         mN5WW+TobjjrwGAuXRwTufUbonp/98tw/ZVxP0dEbNlpa6wLFOLamlT0ys2enuheE6M3
         fK2msgfNDxxrEsENzJROHA/mTBytINrfXdRAV/C1xQFJyEx6LKQ+QD2TFyE+AhiRrGyN
         kXT+Dil9utzcj+U+1OjdgPb5EVLGP6xLkrxzN48wToABd5sThIscQV96urtvTSac0JUs
         oPuVdvIHjx3LFLl/VAms0e2c9gtAczoUw/4Mtjgy7/yJ5OrEhJ4KUixPMfc6LZWnuJcs
         eomw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731333044; x=1731937844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SpaD1h+qgSUegWPIErtuApILd4uPZKqBeb/+8dSEdD4=;
        b=p9H2GgdO8pnbU5Vy29gYa5rR1yNtTdHrDPkZpWKh571+9cPdwsm9mDkKfyzthgF0+O
         tQ6+bViBqffTCW6TjuNdpYgLk0wNYjDMjuwVAGs/7fqjx9LbqZ/8sHcCv3tNR82aqwLp
         sNv1fHb/u94Q+Iuh3SsRfZOJr16SeP9YG6Mzk5hPQsfBu8tai4cH6DRxlHa5k49BrAZS
         /dzz3pT2I37CMegK0vDAyROc+7m32G/QyN6OGCi0a3FvrikLmwqlcFlhJlifdcfkFx2V
         0E3MXS6z1m+qF++SwZCn/hFKPkGUg6AQF1Ncdaa3d/Y/d88sgPMsvO+ylF33YF65hniZ
         YY/g==
X-Forwarded-Encrypted: i=1; AJvYcCXLf0MPIRk10x6bj6u3b6da3wejMA5x3JM58gPrlOlkg85bOKjB0EDaF3A7e7PKKRpNcosJghx2l+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2IfH3aay/j8LOVUIrl8TenCTUkMXHxCtphgHxoot3VFHkN0Gk
	1xKbqUrygHgUtVG1zXRaOObcrP3F5LVa++R/ruelvKbKXTxIix/MWHVL/MV+muM=
X-Google-Smtp-Source: AGHT+IFag61yfodkZmr5TS3cmwy+FvF75Uec4Yswjg4hxvXQDmRP7g7+z1T2wq5sRQC78AQ1tGkGKw==
X-Received: by 2002:a17:907:7205:b0:a99:60c8:f2c4 with SMTP id a640c23a62f3a-a9eeff0d8d4mr1261372366b.15.1731333043626;
        Mon, 11 Nov 2024 05:50:43 -0800 (PST)
Received: from [192.168.0.157] ([79.115.63.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0ad2f76sm591418266b.89.2024.11.11.05.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 05:50:43 -0800 (PST)
Message-ID: <48c1512e-91f4-42f2-a935-b5b8b1506d0a@linaro.org>
Date: Mon, 11 Nov 2024 13:50:41 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/24] spi: cadence-qspi: Support per spi-mem operation
 frequency switches
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <michael@walle.cc>,
 linux-mtd@lists.infradead.org
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 Steam Lin <stlin2@winbond.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Sanjay R Mehta <sanju.mehta@amd.com>, Han Xu <han.xu@nxp.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Daire McNamara <daire.mcnamara@microchip.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Haibo Chen <haibo.chen@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>,
 Heiko Stuebner <heiko@sntech.de>, Michal Simek <michal.simek@amd.com>
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
 <20241025161501.485684-6-miquel.raynal@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241025161501.485684-6-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/25/24 5:14 PM, Miquel Raynal wrote:
> Every ->exec_op() call correctly configures the spi bus speed to the
> maximum allowed frequency for the memory using the constant spi default
> parameter. Since we can now have per-operation constraints, let's use
> the value that comes from the spi-mem operation structure instead. In
> case there is no specific limitation for this operation, the default spi
> device value will be given anyway.
> 
> The per-operation frequency capability is thus advertised to the spi-mem
> core.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

