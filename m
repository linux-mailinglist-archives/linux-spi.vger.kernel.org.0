Return-Path: <linux-spi+bounces-5671-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CEF9C40DC
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 15:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D62C1F22A5C
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 14:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2920215A85A;
	Mon, 11 Nov 2024 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QE8qgCLC"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9FB156678
	for <linux-spi@vger.kernel.org>; Mon, 11 Nov 2024 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731335251; cv=none; b=Tfhi90xh3HoB6tERwH5ml/wm/KXYovg6FAOLHGeTgAPE+k8LZZCZY+g5PNCXBdhIq4WXZ7btnuXfQN386/WzeLTR1ovQ/m7vEgxuzNLqf6sHpAM0YK9sBgVMKTaTpa32dEunqZtPV0XmrGhho5I0AvtNZmMAI7+gp4IRnXp4Chg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731335251; c=relaxed/simple;
	bh=pnb/R/lZh81r5fO95qcrMXPQmjrkikZTx+EMey6q9f8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D8AMVCBWemIxkAk56KoE6C6xKpZHGHnAq3IfE5cABYzg6nBS5URGeqZdYDbXYuSP8aFp5qPQ6I0vB2IwDiAhjUxsA79R8sfE/f6PzX39ODNW7XzDgt/3WZFN5vcb+kXiGECpaC39YfAD4G2LfJAFDgxI/gjbPd0W8gXdbUtzYxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QE8qgCLC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so40233205e9.1
        for <linux-spi@vger.kernel.org>; Mon, 11 Nov 2024 06:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731335247; x=1731940047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pnb/R/lZh81r5fO95qcrMXPQmjrkikZTx+EMey6q9f8=;
        b=QE8qgCLCW10gBuuaPsmO8ML2L3ew34xYAH4klBK9tGlWmqu2q11GZFJ1RLlHOw0ivd
         sr9a4uDvSYkNk2ZQkTX3yu86DfTdVffl01RZ0tbn+6JjBZyAplkGxQs1tRVwa3LShKiX
         IzscK02qIIZaVm7mZi5MA5i5zBZ5I1ZrP9OYHe5eW9M1IculFpvoOtWbGBOpP0pPga6e
         wwfF+Og6pWJ+Gl0VehjX1LyGW2ZwQSkNRoMGYMQ7l7hbmYyMdo+A4Rty9f6WmtfZMsun
         2J6mNUqvrVzgJXv/xaPKP8X5cqBvEPFRNp/JEfeuB4h/FVo27vwKmFgQDTXhOaW53beR
         Pc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731335247; x=1731940047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pnb/R/lZh81r5fO95qcrMXPQmjrkikZTx+EMey6q9f8=;
        b=Uvl1tUbIjDU0pgpXb0/26txJZs8DXvC85ln77oVD52qnBAulV4q0+HHCKWCSgwyQKW
         5eD3p2WDbWIN03ci4VLd4K+HNUVIxgdQ3RQuqnf5TJUpwyBd3qJZPIo3KV8sSzN6tojx
         fCJBviDsgvBWpj0vA4On9fy7W3o4FX3Xu2J3TeP8FxroQsVnb0AMkLBJmLY6jFCoCURG
         quZTmdJVUhea6MMGv8SxDSok9bTasZHdEcG09ryaPEujGukZslgFSJ/NsOQxeFM1Ssok
         My66IYCOsyZBf7C+Pjua5Jj9cVRQohEYohNLOLfvr1/P0ZfG4srypo28mk9GUx6LcUuR
         Os2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUcu5l3LG4IsjHIvdBeW/X4XbVqjd/X7rKVv3rmpB3kqlxjhMh4LOlinoh6NEnPpTxrEE45TuhKCnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0gvlvqzSmqMjsVrGzjMAhv8iF8wVDdLaue1JxkRQkc9JHQP1+
	DFUWEQuUrCyS+q9qZelFvhGELTr5aYyGIBmWhuFCN974WRUAhOYrJmathD8Ye3I=
X-Google-Smtp-Source: AGHT+IGeLWpTjcE4QT9BgWiTbU7KWgVXfhLATKShyxA02C2WRhlBQmi65o2QaKNYOSYB9di0NKh4IA==
X-Received: by 2002:a05:600c:5104:b0:431:52b7:a499 with SMTP id 5b1f17b1804b1-432b751b650mr97501695e9.20.1731335247630;
        Mon, 11 Nov 2024 06:27:27 -0800 (PST)
Received: from [192.168.0.157] ([79.115.63.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b054bab8sm174979475e9.16.2024.11.11.06.27.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 06:27:27 -0800 (PST)
Message-ID: <bad3572e-34b4-492f-8e60-96b14e3424bd@linaro.org>
Date: Mon, 11 Nov 2024 14:27:25 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/24] mtd: spinand: winbond: Fix the *JW chip definitions
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
 <20241025161501.485684-20-miquel.raynal@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241025161501.485684-20-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

do you want the linux stable teams scripts to queue this patch to stable?

if not, maybe update the commit subject with s/Fix/update? Or use
Cc: <stable+noautosel@kernel.org> # reason goes here, and must be present

