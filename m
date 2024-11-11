Return-Path: <linux-spi+bounces-5673-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB519C40FC
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 15:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25EE91F236E1
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 14:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D970741C79;
	Mon, 11 Nov 2024 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tg0CC/W3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E79B1E481
	for <linux-spi@vger.kernel.org>; Mon, 11 Nov 2024 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731335553; cv=none; b=HfF5890m0GbVgqa9HYRHvX6s4GD6igu8cTecUTtfjVh4RbdMR+pbfkdMmHhycjAoSLXBoaP3kmyJ7tFmscVD8/7PrpFoGLACxSP7fqSWqOPgwRoS2UPKXqRe/T03EDXx6mXMJ/HbmGnsbXsBSB/WMebKrilxhdqTtGE//WvdyQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731335553; c=relaxed/simple;
	bh=Qxi2lo7a9rg7PCwkeyye3ftlVdXU/RHzbGZ5/oeuYwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m8AemIX9/zFHk9JszmESSsedHu9owY9pMHQvNfSUR1OyNj30MSMWNiFSGA/hngvUPuAtEh9A11HXrIHCWHKoTUeVrNVSwDzOJp3l67tOJf8+yTrMtlHr714Kdso9SfyrdJzxQkUx+O7+vpjgNYZTMAxEwkmnsnyJFzI1hVO1MvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tg0CC/W3; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2feeb1e8edfso56887441fa.1
        for <linux-spi@vger.kernel.org>; Mon, 11 Nov 2024 06:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731335550; x=1731940350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vHLJ9CKALbizTaLEIHvPwHj1Z1X+PY0wBl98yEJ8MvQ=;
        b=Tg0CC/W3V249QCUYutyTsQTYoS5H6BD4+AWZe6l2LI8lIuC1n+dgFUgebHRpH/nuJL
         upaiXBylTQsvHovMRO61bEum4DSa59Goo1nclxz4hAPhNiYrCwtckLiaJk9QyVfx/WL1
         NWMyfy+RY88GFZrXmQVJGNHcNCDQCJKD+Y18Wvr5LRJRUgfWtFlEzPPkNUKhJHOhOrpe
         YlLI6B6mn7FxxTSNxRyVP2cAxD0/Gmg71EAOOu5n2wX9EgO66GLQ5YpmKyDfQn0aEkaf
         GHN1rhQTUYCYut2nP8xd9SpYTx6bsSsvej/3cWBbaVfk+KCqXx/1TQ7AqgXsumhJ6Rje
         YDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731335550; x=1731940350;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vHLJ9CKALbizTaLEIHvPwHj1Z1X+PY0wBl98yEJ8MvQ=;
        b=XvR7vF9W3MfUnQwuzSw0YnpBm4ZZm7gbdQIlcW6BUgExLC30boJq4IjtQmbb5yO8Oh
         kdPhXv5j3ar5poLaNaK8sa5Zxblo1a56EaEj0OsZv6VJ+j4NSwVBsR3PQauCsz9TJCzq
         txHFEH9rI5w8i0TNGKM2umdasAwXrBBxROH8FhzrcvrrO+8gWqqpi0fMvKAUgHIZOp04
         0vHB8c9NPdMmy0a4Mbk+lS/X0fNwTNV1H5VEBThXNzixo6GzsocYdkuNpT9d4gjgogs1
         O9GzmNBah736ecaxrn4YOuD5Kj/T+pBtNsV1cWlFtLrx7Z6/VqtVj4gMOjpZY9dRxmki
         fk9A==
X-Forwarded-Encrypted: i=1; AJvYcCXWQbDy0X6Uw0Xz4C9MdHGu039viM+foFWFjlLkt5roEYE+4ZXSgWbSL8t7I3v+vtINsspztzImO30=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvAmxBiHTacSdX0beESKCgDNztLsTWa9mduw2dO0/SbkCexV1V
	VnDD6sYi76yUU35xLNRVCK+pcGEfv7+NAFXtNQmb0+4jyk8dxGYQDHvi5OT1cx4=
X-Google-Smtp-Source: AGHT+IEHPK9fFLM4E1mAc55fQigYsoEvrjbPkKaygj5mVOLf4TYnql5Q4+OILHodj38uuQMxRGvOsA==
X-Received: by 2002:a2e:a802:0:b0:2fa:d604:e522 with SMTP id 38308e7fff4ca-2ff20080d77mr90396991fa.0.1731335550281;
        Mon, 11 Nov 2024 06:32:30 -0800 (PST)
Received: from [192.168.0.157] ([79.115.63.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0df0745sm600892966b.172.2024.11.11.06.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 06:32:29 -0800 (PST)
Message-ID: <7871b283-7623-4a21-ab75-42359a7c29ae@linaro.org>
Date: Mon, 11 Nov 2024 14:32:27 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/24] spi: spi-mem: Reorder SPI_MEM_OP_CMD internals
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
 <20241025161501.485684-21-miquel.raynal@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241025161501.485684-21-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/25/24 5:14 PM, Miquel Raynal wrote:
> Follow the order used by all the other similar macros:
> - nbytes
> - value/buffer
> - buswidth
> - other fields
> 
> There is no functional change.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  include/linux/spi/spi-mem.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> index 379c048b2eb4..318ea7b193cc 100644
> --- a/include/linux/spi/spi-mem.h
> +++ b/include/linux/spi/spi-mem.h
> @@ -15,9 +15,9 @@
>  
>  #define SPI_MEM_OP_CMD(__opcode, __buswidth)			\
>  	{							\
> -		.buswidth = __buswidth,				\
> -		.opcode = __opcode,				\
>  		.nbytes = 1,					\
> +		.opcode = __opcode,				\
> +		.buswidth = __buswidth,				\
>  	}
>  

I don't mind, but shouldn't we follow the order used at struct declaration?

struct spi_mem_op {
	struct {
		u8 nbytes;
		u8 buswidth;
		u8 dtr : 1;
		u8 __pad : 7;
		u16 opcode;
	} cmd;


