Return-Path: <linux-spi+bounces-6098-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 354DF9F5FFA
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 09:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71F27166569
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 08:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B7313A250;
	Wed, 18 Dec 2024 08:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HuJeT/xp"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C4935945
	for <linux-spi@vger.kernel.org>; Wed, 18 Dec 2024 08:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734509806; cv=none; b=eXfvYQHVSRuXZoiOKQ/MM1Xxk3OjUG035ndm4VIkp5lWugXvh+qMvv8qOjidUTyE6t6c1oPe26eIwR41pK75uWblDGJzFMo8VtdkpuXwXMujuB9pQr8ghh00CuTziYaTt2qhXT37cWu+IBqcVTmmKPYfFsNaiH1DMmn7No8ee9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734509806; c=relaxed/simple;
	bh=QmWy7LpR7cjiMpsL3MUojEaNgkzXGw27RcQsdpUKyro=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WHyn3ZRhSVqhqgOuA4ZNXKkw4lANmfgMDKAMsXnyN69Di2nTXOBm/0F9gPEFlc0H/S16i5DmXUh56N878sVdWX508ERTxCOfg0X3istU9bK5upAWQJ07MojgnR5dMcXSrKLg88DtzGkjbO5N/ZDocKp3PdgQ/HWKhnKbBA2L6xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HuJeT/xp; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385f06d0c8eso3115011f8f.0
        for <linux-spi@vger.kernel.org>; Wed, 18 Dec 2024 00:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734509803; x=1735114603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wUDp16EoqRsfsIHMezVJP6nqUApE9GquXzhoyupwRlY=;
        b=HuJeT/xpSJKMxwAkWUldBj8Td3/9xxKq5GIOltimww5bSR6+dqy3AkZfCTpI8bXHZb
         MS6eIyY9yHzh9tfkvI/1fuqrQBz22CIy4k35JN8vTdtil3m87ZOiYH1jmv730Dzbfr4g
         7o2pH2Cx8885j/27LwodHQjP+cqaDF1K5wTkx+fE0Wa1mW1VoowmMlAqAdVCdDO6+3IL
         mM2dtU5iJGaIyxWyKHg5gM6+QJZxO2GndHLzVcSjIQ8PR9iqw7TiC0K94Jix/o2qyVJk
         kzuU2GjaKu2Oaud8k1mzjHI+iKDD2ncO1Byd0uw/vE3jywV93IqrIEM+CeuKhYCZ+Jqd
         pEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734509803; x=1735114603;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wUDp16EoqRsfsIHMezVJP6nqUApE9GquXzhoyupwRlY=;
        b=Wyx5O2045ucapsGRmg+ADNIAGicEuQv4Ml5z3ZIhqf6wIJubQKBvgXijfEiOf11udP
         gUEvzcNrRecoj6BXPzBOnPTybCtE9OUxnwN0SavvMLnSF+vWjJ2SAlceelrmCRe49Wvp
         x3l08rbBXQ5dDNpQKfZhSIG9OPyrCd4ctgfjH/2xDx1YUi35H85BdBFZMG8XZ+SYIj6T
         WDSETgZm6scdCJX4TcIJ8w4c3WWMMlZv/8XTwvEWxdtz/ecMj7qWCPNkTUzCGHBsMQuW
         ecvw5RjxsxnFEL85oYIp9NtsYKWwkbgXGk/hBDCrYH6HGzaQqhA2Ug+l4jYuvYjCEYTP
         oHtA==
X-Forwarded-Encrypted: i=1; AJvYcCVvI7WR4plGQ6e3UDg5bxTWROeeKYzbRLC4zIict4B+49pdMvOTcS/FL6gwAtQgpxStxA/gNhfwKR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB/WdTYPzqPfaSa2LNGSLoBZgv6bbOCLE8LNSH4RqOTdmg0hrp
	LuOYghRMC8zXGsfhHr83PGjFGTtX+Ao/W5VN6pyTVRIXiVU+aN/FLKFSgKIbPvCF1n+sgc2PTxp
	h9Xs=
X-Gm-Gg: ASbGnctVpQBlmhlEkBftKiB12D3vKvo7FPQGdYUwJTyU41EGLDDkCtR/qxCss5a9bzD
	kpoGAcI4G1Tma1e46QHUEr9pUyHUNh2HUQAJcaHsEk+mbh3CY1SN+Y5dQjBL7pfPDzc7sV82sxF
	1DftuoU0i1mzy5G2ugBoL0seEUtegVaFEm2i+bBriYS04WnWOtBoqVcYYJEUft8yccb0y9/oGgJ
	EiC7XykyiUSVZs7HY9amRd5bUE5onb1C/eCxijn1f/tFK96TJe3yTAV4eOhvQgn
X-Google-Smtp-Source: AGHT+IFZoNEFr8+5BPLPh/Vm0J4B2pIJzFWkSIhCJGFE4SnpTk6l6WiOeJftw1zVlj7IXYgeu5TeTg==
X-Received: by 2002:a05:6000:4b12:b0:385:fab3:c56d with SMTP id ffacd0b85a97d-388e4c97f56mr1823422f8f.0.1734509802912;
        Wed, 18 Dec 2024 00:16:42 -0800 (PST)
Received: from [192.168.0.14] ([188.26.61.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8060862sm13155133f8f.100.2024.12.18.00.16.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 00:16:42 -0800 (PST)
Message-ID: <4f523ed6-f896-4c0d-8ccb-66083cd2a3bf@linaro.org>
Date: Wed, 18 Dec 2024 08:16:39 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/24] mtd: spinand: winbond: Fix the *JW chip definitions
From: Tudor Ambarus <tudor.ambarus@linaro.org>
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
 <bad3572e-34b4-492f-8e60-96b14e3424bd@linaro.org>
Content-Language: en-US
In-Reply-To: <bad3572e-34b4-492f-8e60-96b14e3424bd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/11/24 2:27 PM, Tudor Ambarus wrote:
> do you want the linux stable teams scripts to queue this patch to stable?
> 
> if not, maybe update the commit subject with s/Fix/update? Or use
> Cc: <stable+noautosel@kernel.org> # reason goes here, and must be present

If this is a fix, would be good to separate it from the series and send
it as an individual patch with stable tag.

