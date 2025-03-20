Return-Path: <linux-spi+bounces-7245-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C05FA6A60F
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 13:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64FF2188BE4C
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 12:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3BA21D5BF;
	Thu, 20 Mar 2025 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ccRvMMc4"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398DA21CFE0
	for <linux-spi@vger.kernel.org>; Thu, 20 Mar 2025 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742472632; cv=none; b=I0SWsfE94jXnp0DWJjnwxEXEu5ORaXweXLLV1ymFj8LNNlxCRpMxUVWDqmgUrw4iFWc6hY7pEl1av0wpj+21XYC0gGCLArQWEkYJ0hzsPJMZaUxlJYl/8mo4Vu/MtHKb+AL0WYugbRUG+rigbeFXL59rO7NYb45qZa7gxBJAUPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742472632; c=relaxed/simple;
	bh=Yyfk8X7hQAsUD9G+4fe4CzUE4boCyIRsCV8/4Z21Gnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lkMKM/F2tKIYZUKLuUOVWY9rYK2ZXLUj0w34YpUvOzmTfrBX60W4dhA/T/hu1AZ4CfY5+DombNxhM7/MhqLayF25yxPcvUuxqiAkE1q8W47VezRW/SOtMMooa6YXGOEDB+iOedCD9s8wVIDGg1YiUPVGWzEzxr/J8GUgnQREiPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ccRvMMc4; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so6308965e9.1
        for <linux-spi@vger.kernel.org>; Thu, 20 Mar 2025 05:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742472629; x=1743077429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yyfk8X7hQAsUD9G+4fe4CzUE4boCyIRsCV8/4Z21Gnc=;
        b=ccRvMMc4wwTC5+yQ0umYlUTILedkfcQJyYTeG8uDndq7NLiYFpi9qwlKe9lxE1Ruvc
         VfaoZ2cst7tpzviN2mX84MXe45YXBWm4NyGqV//iacuzKqNRU256gKNZUlhIz+Gh8YwM
         /pzFT0N7CQXgWcyObJaut+ZfG1HOoJKb+UeYXw1VVgScMZH4mb0nNOAvLbwiXb3HCHW/
         XlkAnPgDxihH7xnhk/7zc3ZH9pywMUBrhDCQvKlaDlN2PnL27oN+fy92k7S4FXbnATKq
         eTb8qozimP1htJb7ip3OlW4/MGEkuRJ5JrUhYXEaLQ2a8kckk0HhvajqdqsZdD3Dgx97
         qFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742472629; x=1743077429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yyfk8X7hQAsUD9G+4fe4CzUE4boCyIRsCV8/4Z21Gnc=;
        b=oDXiSGlX+fUu6G3IuDaaY8aD35bt540kDtJXAk3QzjLk7NXO2EShhckVfyeDjGMmJ6
         J8mw4HfTpVpn8mCWFQLIsPe7qzUIwgFDOPQtZi8o4OZEgjZ41YgIlBkcGpE9MRKjn7dL
         KcTUBSOT+rfV2L8MDu/B04fg9PdXVZBeXFJi/nmCOMLDPdo6LrbTYEizw8VvfjV4tAXD
         h3nISYoyVlyM/yPQBTSGWW7mR5uvp6tDuZiyFnr4HFG4u9bGG2HG7RtCzPcnzrjsqK8q
         rsksXJ95NsA3vT+f9jk2ysCkxwdqM/XY3rZOG7uzLeHqOv1+jsafbe/WI9XvfhEi14Cu
         xSrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiAxz2BJE5Xb4EKhcVzICLWLQ0wskiYCNiGu56gpFsdRsIuq5Rqwoq7xU96Ox3ZCIAeQM398GyzBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTWGkhO5HEGdnCClRDh1Ya53ZS9w7KymBMMpRx8BaAqMEBc+eS
	fng9cyRZB98CiwPsTvqm+CHxOWDjSSjbDgF6zFsTsJHQZWINsszw01H/+4oWd0A=
X-Gm-Gg: ASbGnctFYoS0HIwMotGsZvAjnWlit4L8rwnrTOXGY7AKPQ+wu/U8Rybj0g0jTvBHEp7
	IohjIteoMOJuMBgvCnD348e+w1tS/+dN4AEJoKJD/zhC24EYCyOs94bvUTX02hgeS5XOiYYGLu6
	sKrb266EohnNmzuYiFLA2aMhIRjwOAmZL23L4BQlwXEI95p84mG8NspW6lRZBLIbdsmR7jyIlwF
	y9V0V1fa+8sp7UugNPYT+9sVB5Jp/vUZ3t2WVsltAg8FPAuE0ffxNYcNyuU95WfZz9Nb5l4MU3V
	CHEIL2KoXx8yYsP7l7/W3LAJUE4rEW/czAljKsVKmPk7Z/kyQ4c3nw==
X-Google-Smtp-Source: AGHT+IHSHEnAtCV472PdfnFW98IAihH7mJvzaZ29n1/yTOK9+JEss+YYOZt3hAmGvjq3O6DpMDzK8A==
X-Received: by 2002:a5d:5f89:0:b0:391:4231:414 with SMTP id ffacd0b85a97d-39973af92a0mr7530290f8f.40.1742472629340;
        Thu, 20 Mar 2025 05:10:29 -0700 (PDT)
Received: from [192.168.0.14] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d3bb2b2ffsm58289185e9.1.2025.03.20.05.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 05:10:28 -0700 (PDT)
Message-ID: <d93de101-42e7-4433-8c77-a8bcb5a9ae6f@linaro.org>
Date: Thu, 20 Mar 2025 12:10:27 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spi: spi-mem: Introduce a default ->exec_op() debug
 log
To: Miquel Raynal <miquel.raynal@bootlin.com>, Mark Brown
 <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Pratyush Yadav <pratyush@kernel.org>,
 Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20250320115644.2231240-1-miquel.raynal@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250320115644.2231240-1-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

