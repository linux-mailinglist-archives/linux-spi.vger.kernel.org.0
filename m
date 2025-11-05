Return-Path: <linux-spi+bounces-11046-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD05C36979
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 17:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 295F81A417CB
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 15:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820F032E732;
	Wed,  5 Nov 2025 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QLXXnzPh"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA5532E147
	for <linux-spi@vger.kernel.org>; Wed,  5 Nov 2025 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358030; cv=none; b=WiUDLXNVfVxk9Ny9ebqOTHeOfwjcvKEbKFFh38RZPQKDc6osF8BmDMzxiOTiDPFnOyntIz91XupZEjO+PP3cHLXWLLvEuWs7nCrBQJWVCC9Sx8CFdG+O7mOH0mKnUlhpdsX+EmTYntoYvhZnZ24qBCcwEJ8+Hn7x9LuPIe57IqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358030; c=relaxed/simple;
	bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nVlgQMglxoY/Kr8SsonQDs2/lhsByLcAgVgZk8t9qij/Ob/9udHi88b0V8AGjLKhc37qFvZxo7y40MTbUSSCTQR4zhkuD3tccxno04189sGphzce/ppApudlWEzD1PPDEsuR5vjYZ1UDalG9jzRBYCU4vM9gjXtjcxT6TTAuOWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QLXXnzPh; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b725ead5800so181568366b.1
        for <linux-spi@vger.kernel.org>; Wed, 05 Nov 2025 07:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762358027; x=1762962827; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
        b=QLXXnzPhRMztfm894pO1r4Trz90ensrbbofHRnMWo1o98yttPShgFz+huUa1H/OBGz
         lRaxDvN0akEwh55XNZM1JzaH/ZxG35+sT+ktFZCn8uDYZBUdk32u/YcPUT05YIfUMJUN
         mpNvEghz3QwkNLgfFalw+hjLp+Z/i+dN3UyRjPnKNCWib8vrNBtmDcftfE/03oiDWAm6
         MvDKVKLlrBSdBiaP3R97OaZiKpVDw0yKozKrHANmcw/H0b1d7hGWqVTITZ3eke9FEO4a
         gczAUbdHRVqbOWkRYjEXGHK/S7LBeFTgL3zdaLy7ruJvaq4oCLqaGbtBkX/t2AhobtuL
         10iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762358027; x=1762962827;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
        b=jTPPRDH6UJXMzCRGFusaz/oWF2jCIuEXxw+s2BXTjOGdO3n1GoEqDmkDNWwGbqB6Qm
         Ib0Dexg8t5d4zJzb5xZ3JVvDZYZ0ihDOzjCfxtbh8LytOC+w5sF3+LFmV13VF4FuuuOb
         uXPqGiZ2oQhxg9nyt1IPBgJnaVgrmo868xH6UOC0wKHPlNLvFF3W31ci6DaEq6OUAV4c
         eIGlmPFTYFGs9lrgGrmz8ktI1vf1MofF34uS/01emyLGqTcATYSDGMUiGs+asKznI8Dz
         TrfGdqNPCsLVuakkxuM3+ebetodaZLpZ1iSY8NX2Z40gGcB62oEW+ApPqDcVHuH0oiLG
         jwJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeSWIrBB+rdoUUZDTLKKISEhQaSbUAYTDeWWPAH8CJtwU79C7zH+ofygwaBqJ1VBUoMJ6m3kUVEvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTjuiNRsY3QgswLKlRQKazClWzxwWAGkCcPbRvwgpNtKkJx4h+
	Y2vmx+IfWw4u/FNRsn4Nw88BOtKieHOc4nS3YNFkfEgaVlFU2+cKaZqo0UDpb3NGuFw=
X-Gm-Gg: ASbGncsfBJgEZqH/vLI+tsIGIfwaMcLny8Lmfmzph9/YMG6EpafqvE/a2ohlSTaIUBT
	deypLU2xiU9XmCL2P0F8ZmBHTTuWdA/1gBt/fFVBcarGOfGaJjmQ0KxcZTAVLx0CjXdwSAxxrlf
	vexcODbKS1zKp+3ieQjv8Z7hVUF0b6XnTS8mUkDKRb2sHf9cCRMuBWl2oeFc4JG+cRA+uEfv0eX
	FHIFt54ptTm0piOARXQGE/IwSwvfnLdll/alUS0tyz4EkMjYTYDkPB+3K6Y9SVTCiAgLOMuf328
	oI6xUmTIXGF9qpWxl7AaQ5STJs01Dm2BTB22T/PDV0KAa6vzW+ZUmaiiIBTCe6gbABGkSYrTFr8
	F5E6rjnIiBE0dmvsw2yVLNBOZgdavfRvGlevy8DYoCF2qwA25v2Z8WD8kF25iBZ4SZlm+DpFtsi
	+HrjA3g9zs4J5PSW07PgNDO88=
X-Google-Smtp-Source: AGHT+IEhBbB+aDttEEGQs9oOQQ+tXYqrRQe+D+B+YbWiBNmMQeVjILVA1dM7D5N6K2h4GWUGw/2OpA==
X-Received: by 2002:a17:907:1c2a:b0:b70:b98a:278b with SMTP id a640c23a62f3a-b72654f6507mr345447466b.38.1762358026889;
        Wed, 05 Nov 2025 07:53:46 -0800 (PST)
Received: from [172.20.148.132] ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d91990asm513705366b.28.2025.11.05.07.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 07:53:46 -0800 (PST)
Message-ID: <b940a35f-2e7b-46d6-8af5-42c60263c528@linaro.org>
Date: Wed, 5 Nov 2025 16:53:45 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/28] spi: spi-mem: Limit octal DTR constraints to octal
 DTR situations
To: Miquel Raynal <miquel.raynal@bootlin.com>, Mark Brown
 <broonie@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
 <20251031-winbond-v6-17-rc1-oddr-v1-3-be42de23ebf1@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251031-winbond-v6-17-rc1-oddr-v1-3-be42de23ebf1@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

