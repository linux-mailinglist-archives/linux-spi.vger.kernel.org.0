Return-Path: <linux-spi+bounces-11056-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA25C36D01
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 17:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B5D96829CD
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 16:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF422DEA72;
	Wed,  5 Nov 2025 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HPNjt3AB"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA50631DD97
	for <linux-spi@vger.kernel.org>; Wed,  5 Nov 2025 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359472; cv=none; b=THK/C2jO1lL3ZO/DfNI37FjwEz71Uoevfn7oXRd6LHb1pOHZZOi7Ha2hP4cMm7SSNXTO4IQPkIo8Vq8S/yAjSO/YWSIFU4qUVKtKj9NC05XSnSkDQd808nY0SESDXCrFiP3MkRyRPypzTnURN8AEZQ2jCtaoXx7uGAJ1MxCO8QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359472; c=relaxed/simple;
	bh=PhBGQ6nFBF+atfYcqmQvtOjXbckgxH+TUDCypzrRKAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aiw7Pacx5XtuVvgLitzxTLs8FiACz5UikOeS2KamTlaiXGkXYCIxyh/wJjgOBCXhmcN8XdXwlHwQZFjtZiSGqYKNlJ3eC3IeErbuoEcNZnH0mG0X84NmToRdZQXK4AT1SSaH5u3HFsh9lU0r4M795b358LpF3V7H9V7tyiIaYLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HPNjt3AB; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-640aa1445c3so6763244a12.1
        for <linux-spi@vger.kernel.org>; Wed, 05 Nov 2025 08:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762359469; x=1762964269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PhBGQ6nFBF+atfYcqmQvtOjXbckgxH+TUDCypzrRKAI=;
        b=HPNjt3ABeTNFI/TyciEKXRK35ZezkC3AsGqlDo6n75FNr3SyyPVc97QA+uQzfVES/0
         3blDn5Od4rYllVH1bpYnK9juCfJvOXi2+hypWX2VS12sFJJSu4n3In/x+eGhVFQG4Zk3
         lw7W0/YVZaRF5NNV8HZN+2whZJ8b0JIMbZSLTOJxL4h0F2ofa3twxAiiIiNbr/1E9WmX
         aAH/Uy2ZHuixcfjRjfUkWaVb/eoX01aX5Rirc704MOdKHc1IfoFIJys9KPpFdns+q4zl
         2A85fe2eNRdo85LHvtR0xSmjoqQZ/piAHJw+zY1pnXn32vNmDglxo5Hn9XU+8mscfdWu
         tNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762359469; x=1762964269;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PhBGQ6nFBF+atfYcqmQvtOjXbckgxH+TUDCypzrRKAI=;
        b=Aqw05pTycWvSthB8jEu3TW4AhnRBzztb+SO3zT66Yu2tEIm6hSdKdSlNBXQxMPQ2AX
         gLT1pr/mkc4bhfDYt3F2FubVVzy2fn0bGufvCwpmsvZEbDyhFLJOmrlUXk5tegASjbB9
         RKUTVtqNIHLjciAGpiFoBw0ICi13ee73hCWo6UOfrHBAD+Bh2fYLyNw73Mm8DCxOY4sn
         yhPVVk/BmMLvNM9DG7AxcA0BAMJisZW7G2JUmKDba3SSg39D/pxYLmUJ5BMkDDmsw/to
         PCdJGYZqWzmQn61CgyzD8rdwPrPBsAgoDh67GgEpkmIRE4zA6arHRy9WFkQKFoz3BeTq
         XN0w==
X-Forwarded-Encrypted: i=1; AJvYcCUJTqMfk/RrGoxjdCXJpEoyqGgdjEZJWhrrzGcB46MJqWWf+Nt++vKThSLnfUiCv9P7dNW1NV0tSuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn71IN2xu2I+9fNC6oZNjeGbjtCW8zFjAYFZW8D6vkBE2ljY+K
	RLdiobxW70eyZRHzAKCLOb7gRtFhgoeyBHubAdcwIpfbn39MRtZ3Q4SGgfTkDuoKZLM=
X-Gm-Gg: ASbGncvKhuo8tlRZkbxtWXTIjXQyYysbks55sgrv4ELZzDMiX1LjqmrhNYMOdh+W5AM
	p79JwOS3ioWPS8pfIYsrPRKpa+9yEcz/xd7Bz0IQS97B0vyaA7G+mRcgBz/M/Z1HcVQ4cajrshw
	MS+mGUog6B00ciexGuKQHQ2//y4bO/9rlJV/iNHdokooeX4sN16Wzx2wIpYCKKCjjiSGJgn6BcC
	J3cBHThnyX4LqQuNTV4Ry3iEv8LUciFd2k5mWHnnLvQeJbMHxf+UvF90XBua37XKZwm/JPXuInx
	s9KvmHdag5HVeCoBVVOe6N+7eAGsT/5W+iihP/mDUHibn1/d/h+xccuwXnoCUwEO6gzYCDzSDPw
	SQ6El3DhW1D/hNWK2jqDnw6KgCX9GMkZZiTlV9YYFpeTWVan4BdMC8I2mrm9lzmFSiBqhms95ny
	Jm5d4FEhQZWgsDCymQq9SIfsE=
X-Google-Smtp-Source: AGHT+IFe9VgZeBsm/n9mopNlUCpQdXSC+eyg2Nz3OAP18FTVxYUDNKqmICDXSKw1lMgKMLixqXfVow==
X-Received: by 2002:a05:6402:51d1:b0:640:c3c4:45f3 with SMTP id 4fb4d7f45d1cf-6410588dba0mr3398799a12.6.1762359469142;
        Wed, 05 Nov 2025 08:17:49 -0800 (PST)
Received: from [172.20.148.132] ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e6a5cd09sm4921331a12.20.2025.11.05.08.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 08:17:48 -0800 (PST)
Message-ID: <7b10d3f9-40fe-402e-996e-81c6684c20a0@linaro.org>
Date: Wed, 5 Nov 2025 17:17:47 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/28] mtd: spinand: Create an array of operation
 templates
To: Miquel Raynal <miquel.raynal@bootlin.com>, Mark Brown
 <broonie@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
 <20251031-winbond-v6-17-rc1-oddr-v1-9-be42de23ebf1@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251031-winbond-v6-17-rc1-oddr-v1-9-be42de23ebf1@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I like it!

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

