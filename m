Return-Path: <linux-spi+bounces-5674-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 968639C410D
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 15:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20F40B220E8
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 14:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D3315A84E;
	Mon, 11 Nov 2024 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XZbiReDN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262F816D9B8
	for <linux-spi@vger.kernel.org>; Mon, 11 Nov 2024 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731335731; cv=none; b=aWqrP6+BdUk4P69T8vRr8+kq86HPhaRNwj6zhlghlLps6I33qBAJ4HOfgK6fMLrP6+1JcfmltJcuy6hycAqLjNOGY6wiaoHqzdYOCjxI/atVh6JFciF5v/5lrbFd6cK0Xts8PZtYAbmOmeFdW/rzMaZ9yxS8ckSSmjiBMZ4WL8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731335731; c=relaxed/simple;
	bh=pEuKiYCkOk3AIZrLfjTskkKF/SawR9aFgy/HsMYaMPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FZNn7/LarMXj0HNVvg4HmlVc68b8+F6mrTuiSh1J3pEF8JR5Y5s+NqCip0QD7cnVaFWRyvx+kChPEWPsgck+03yfAMynNm0c0a7uMEZoSvUxwx5XCc4Db4pCx+IAcVBYY1Yl3COGEJ0xSWq3TWw0m5GiZOJJOvFBmWIVh15k04I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XZbiReDN; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9e8522445dso822260566b.1
        for <linux-spi@vger.kernel.org>; Mon, 11 Nov 2024 06:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731335726; x=1731940526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iLnMMIEFVPuvIElYENom7790GnOLZ10ipAw6/ptkQmU=;
        b=XZbiReDNUjW1JaQ/siqNnu7ETzPX+W0P8Ui7J1/Ys3agAAHNy7z5FYodJwTdw+qxfx
         Td0dVFjpE6+0cdXJTkZZ6x0eJ35ta/ocAUzotQ0Dq/mUih5Q0QwIdV2Zj14SkAI5T17J
         HNckhI4JGXApXa5/Pv7q7XXveqyyjXtlbMZ2hvGdXzK9pKQYcjH0xqKY7NaF7GFkiHy0
         Rn8oDdb2N2wbRRO3TXSb1CoeSd/1UL52iniZlBvDLrS2AnW/odJPJcICeEvZe5ItAZZG
         i2REY0jRgEFW8EdCcN+fBHDICRrMWsOZGYkjhxynZnRVKP+VMFcf/1LbGB4q4h1E9hbp
         9x7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731335726; x=1731940526;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iLnMMIEFVPuvIElYENom7790GnOLZ10ipAw6/ptkQmU=;
        b=PzXq+BiDmvqnvI3TiEvw5GUYdicwY9UizJVRF64yJ9LzLBmsZ2dx3vyd4oqimay0QD
         kpaoAPc8o59t6HTWeua+48GAAMvOfv1Iz3gxLhz4AHFcFzY2cXb5++YvJBDlmhdN1gOS
         5ZToeQy8bA9bUpEFs5GzU7LXWlklez/4DyLPDQOrDt70Vqv58pF7JFnTxxfX2uV236xn
         Q8uKm1QYae+CO8ZHaWmJr9S5vQ4oEb12J1eBiolsls6nNtwaPuW+fbreFgDluEQxusW9
         l5yHiJGNCwgNMKsXVjPMzbPqcum3SpWIXa7npZJgFm0dD/SN3TNu0Za3LYOZzdg7VGdS
         Q2Ew==
X-Forwarded-Encrypted: i=1; AJvYcCW6/cPHhQDheP+I0d6C9iGpMO6jURjKCn4x59S4hvxq5OKENOPSAMLums6RcgXORjNVkTf2Eb3gBp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMRhR7borofouThxZRjH+7cQEVMzdZMar9abso2i07lUEeesKr
	3R+8CN14PwS4ESAKZg0c0WNQkk98kNwvShsxru1zIgiHdUJz7Z800BMFnwpN40k=
X-Google-Smtp-Source: AGHT+IEpv164JsnmQty3/uVxJL4q/z/TFjLw8T+y/UoHQHuSo7V3bvyRydQi+vpy5Ssnlz7tyRuBkQ==
X-Received: by 2002:a17:907:6d24:b0:a9a:9df:5581 with SMTP id a640c23a62f3a-a9eeffeee58mr1280694566b.38.1731335726454;
        Mon, 11 Nov 2024 06:35:26 -0800 (PST)
Received: from [192.168.0.157] ([79.115.63.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dc50afsm610346666b.122.2024.11.11.06.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 06:35:25 -0800 (PST)
Message-ID: <589d95d3-9153-475b-86f7-886ec41cd4f4@linaro.org>
Date: Mon, 11 Nov 2024 14:35:23 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/24] mtd: spinand: Add support for read DTR operations
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
 <20241025161501.485684-23-miquel.raynal@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241025161501.485684-23-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/25/24 5:14 PM, Miquel Raynal wrote:
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(0x0d, 1),	

do we want some names to these hex values?

