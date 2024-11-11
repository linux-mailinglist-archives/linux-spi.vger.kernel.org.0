Return-Path: <linux-spi+bounces-5668-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FEB9C4079
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 15:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E271C21450
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 14:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95E5155CBF;
	Mon, 11 Nov 2024 14:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XhBfa/rm"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B9A19D881
	for <linux-spi@vger.kernel.org>; Mon, 11 Nov 2024 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334476; cv=none; b=hcQBBd8PK2LNW5thhrJ79bPoHW9GwdR14yeeeMt5qFIjyt1SRd1VeOetsDB0lYji3z3tYT5KXtF7Z292mo1JEkbocpEltb/hGyz9yW+BiS3jG2qf7xgO++bIm+Ikyd3WOXqER/P6TN4QUBWQ8hWeW56fbPJWoCSsP6hCAAiSkE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334476; c=relaxed/simple;
	bh=Yyfk8X7hQAsUD9G+4fe4CzUE4boCyIRsCV8/4Z21Gnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mw/MCNxNPChL7QqmWtfZH87v5EXcEUW3WH54vmz2j0HmIEJ8giK+ObPUKdluaL/lMYxO8EFgVgXu6KNwbvz1AsDMI+cWKXjAjEDX0j7ZjscTf95vT3CdxTo4dNqTWQhN/Jl/1x+zlqjbLgYjDaeeZR5O3nMuLQtoWkmI+XJQfQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XhBfa/rm; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so40105345e9.1
        for <linux-spi@vger.kernel.org>; Mon, 11 Nov 2024 06:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731334472; x=1731939272; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yyfk8X7hQAsUD9G+4fe4CzUE4boCyIRsCV8/4Z21Gnc=;
        b=XhBfa/rmLzAy8p8giyd6iczH/s0Fq4Zkpj1Y8M/8rQowulHohQkduuvhH3wexXlXRM
         uVd2g27JpK5uymuaPq5Zj0BMniKMvPGhlKYVRG8scMDqsh0Oh8ZMCzSy9EpLhoOYI+88
         DDKfYstZp/7QYPshKNGihDE/IpdKT9cmek30+J4T4usIfxkhahRneyr+guQ8oY5zrN1y
         y8XTEaOoS6Vz9OZV2A7DioMrRAtQ4EI6DtGnHutvXrH2ghqRyli7B9khqiQt1pouwk3H
         4AUasT//vz9xbK7IiCU4EIFvi++Pi4JZhRqeusrOL1YWM2y72Oo/lsYXYmFyrRw0kpic
         f1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731334472; x=1731939272;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yyfk8X7hQAsUD9G+4fe4CzUE4boCyIRsCV8/4Z21Gnc=;
        b=iJeCAnEBXMfMHfu7H99vbvKdKh5QBHzQ72+eCNs0oh3+mwFjfXSgI7kkQcGuyQKzK0
         tKv+AI3DBWwsh6Y1tvWeSzoJFUHK+I/REr86NKJKb3E7YEoLpnTEStvf2sb1wuMBZrqk
         /Xa/1YiGTtiralnYR4FHli00eF04YL7WDPDWdlPGCAEFdcCe70wQzR+DxZyvllJOBLbo
         jfTZLrtTgZ9i5ULMc+H6Py/uH+6k2FM6ePBnu3U5FSl+uyp9UCVl1jZ50o5OKOyvKQIO
         xfahTupl8Mxyg6JI/Aw+tNbcjsdpIZN3JrBKkGXQtP9A/+ukdgdOnS48ZnLtniZ0iXqv
         Zc8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHyzfo68g2920fpep8a7TFSliEs5vPJ7I58Zdvjug6FgjIA1H2i15nNLKh+Tx8KtyF34O4s8EQC9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjinnD31bv6Uep49yY/uteDbtrDG0Nri/548gvbxPho0hp6rc0
	TFFQAivoMPGfEbT4HvhyOx22oOPAWEdetw+r7YIvCnXjMy2Pc0uMHzQyRzO1M1Q=
X-Google-Smtp-Source: AGHT+IEjxpaN42IB5iXA9LD/vdpXn6jKpzUv89sH3e/tLG/BKIRbSkuW83EVZx1SLvAlFImY7Yn7dQ==
X-Received: by 2002:a05:600c:46c4:b0:431:5aea:969 with SMTP id 5b1f17b1804b1-432b7502702mr108986925e9.8.1731334472027;
        Mon, 11 Nov 2024 06:14:32 -0800 (PST)
Received: from [192.168.0.157] ([79.115.63.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432bc4f67casm79446165e9.1.2024.11.11.06.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 06:14:31 -0800 (PST)
Message-ID: <a187503c-a7a4-411d-8d45-d684efeebac3@linaro.org>
Date: Mon, 11 Nov 2024 14:14:29 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/24] mtd: spinand: Create distinct fast and slow read
 from cache variants
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
 <20241025161501.485684-18-miquel.raynal@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241025161501.485684-18-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

