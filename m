Return-Path: <linux-spi+bounces-7756-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D233A9BFD8
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 09:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 400D61B67F8B
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 07:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F36122DFBB;
	Fri, 25 Apr 2025 07:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6DEdwwN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7C022AE71;
	Fri, 25 Apr 2025 07:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745566581; cv=none; b=Tf3dpD3szKIa8QygtXAzyAV9f3ne3AqeHehgHQHtypJJkOj1lKJX2ox6kowmE1BbRfGh3q1R46/z9HtjqzZ8Hmi7AAa/s+trEYRqSj/OLStxXrIHnfXYNbKvDX2enpsCpgvtgeJtQlFnMiPBk5Sx1I1xXRz+fZjTjEUyJDZ+MOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745566581; c=relaxed/simple;
	bh=rCNEArio8e3RBD+N9jHCQd83TgIxf+sAlEPyMwlfipQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pixQmauXPrH9FKgdhqkteMfGokHvg2bMlXFuG6LKXfa7Zdrtq5Thv+A+XfVkytnh4FBoypR6UisEaCTd2sezAVAjCoappKHe1Gjc1Gq72bWG7rmGKBW2aJiWGy606O/iI2afKfO+29AhABWhe/Un5syI8vkfg6J5tyveJm+bq5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6DEdwwN; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac29fd22163so277128166b.3;
        Fri, 25 Apr 2025 00:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745566578; x=1746171378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f/aoAOajG2LJH/fap10d3juwU0GRv8oLLbcqOZ94sZ4=;
        b=c6DEdwwNlJC6MgZwgu0z4PnQmlDxpTopy5bLgYhZcXhTf+rrviKuQrZfdJ/oxiNRcl
         Fhbxy5omN+ft7In9AyZL8vQ9K9sucH5krE2Hb2/vuITVDr/fV8cfu9H1nyaC+FAaZ6W0
         BmFsxD6JOpI9OwuDqXYmEbzJ4tkPg+ExR6i1PvBXdUa7KK0mSopdKYE4PthBjHHfh+Iq
         7WED4tYqcHpWvG435J0JNbY6RSw4Prh6ELqkUGisELFl07QEG8GSxvfAbwoz1HktWQT3
         g+b7aT4pmIiXuCPmjT7HvzUYQn3hIBBhD5q4JBKgg8td9KNpIhr34TiNf0hrI5pHhe7L
         SV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745566578; x=1746171378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f/aoAOajG2LJH/fap10d3juwU0GRv8oLLbcqOZ94sZ4=;
        b=JlGOUO6Gl1JE19NWtxyEJ5zmzUBRHWwvuRHqz13Pzu/Om6pOLjriZ1yaSyQQrTsw4A
         SHToEAkSosZsRwaNxfzZSS4uxbVWT4hkTEddKepdx50R8yWmOKQ2J3LxCOwYpEyPHMYw
         x3yDG8MKrVs3RypbPbKOcrK9tw9YSVC6VKE5i7emZ0eU9VLjgO5bgDrO1d4j/3eZuTkX
         iLQwCw0r1z4einL9e/8hFJ9wNtnvGjRM4uLG62UMPdDfrWM2E7ZuNSO47HQlT0fd8i6Y
         xjc2+PXr2X9a6y8J2KIS+iHnsyxRV8OB+GqxsLzZtrZ9cVLpxYXoJ59PbeTJDdB4ApLu
         +upA==
X-Forwarded-Encrypted: i=1; AJvYcCU/KaVTjyBpuvhIZXowu31Xd3aLxebrzBpQZWtsh+DlQBb+zHxWLSxCPZxCLN8arRiL+MKvZhtt+gw0lfeu@vger.kernel.org, AJvYcCXYtPxqrv0433+oWPUizZGbYu+3CuHJxZbkRWJt/bT9ovrn+e47PQIzeFaxjcapyaEFiRCuxWnXzjM1pnVO@vger.kernel.org, AJvYcCXzAzY5uONtfexFhGFQhU7LU9UrkUgfOPu28uYNwT5CUzgGrNGmZw81z7VZui4u004RWJ6p0fcgmAGE@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0pOq+w0MT9GpqyyaBrfCgUQf1+g+ZwD2dZysYygNV5fyQdsEQ
	LQ0fUZqWDENcca1y6UnE6pkp9hi5/zS+cXHihbiVBEkjL8IgmQ3t
X-Gm-Gg: ASbGncs+711fMJ6XYG2b4NhEzakPy9uHVzow585E7IRhSsdOl5nMdb0lNKw2nGk2bDI
	duv+eH3spC+xetyhahyWP+M3HVOBmZltEu+qr2oupxlzm8u/jxmq6bPo+J3dsIsebro4tqZIA+/
	yyZJhYJVFLZPfk8O9gKcajtwpTTtEgSfYisBP61PyqJY4EZA8Utdnc9QCU8Xr1Xvfqt7h8T1kKP
	JMecSpfdWSAOte89a/pg8VMJuS2/5zqGA3RdNDbOehIe6eb2gPt5DsV02xT0/N53dq6uzP3jFBf
	0H5E+XdktGTiDpmPQKF6OsmkGPKEvVkpsbUKpfyK7ku5DNnWPJHbpWMKv5n2z8MeTLSaCu4AClV
	fGcovpw==
X-Google-Smtp-Source: AGHT+IEFRDNwT/tszm82KKO50dkALibFBs/YMWdHV7MAruEyimBlWP+qHuPyZVHwmxBzxuAdsnf6Bw==
X-Received: by 2002:a17:907:1b1f:b0:abf:6d24:10bb with SMTP id a640c23a62f3a-ace7136c44bmr114322666b.44.1745566577785;
        Fri, 25 Apr 2025 00:36:17 -0700 (PDT)
Received: from [192.168.20.170] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ecf8cb3sm89574966b.93.2025.04.25.00.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 00:36:17 -0700 (PDT)
Message-ID: <3850e8df-9744-420d-a5e0-46cb85b76fcd@gmail.com>
Date: Fri, 25 Apr 2025 09:36:16 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] mtd: rawnand: qcom: Pass 18 bit offset from NANDc
 base to BAM base
To: Md Sadre Alam <quic_mdalam@quicinc.com>, miquel.raynal@bootlin.com,
 richard@nod.at, vigneshr@ti.com, manivannan.sadhasivam@linaro.org,
 broonie@kernel.org, absahu@codeaurora.org, bbrezillon@kernel.org,
 architt@codeaurora.org, quic_srichara@quicinc.com,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org
References: <20250410100019.2872271-1-quic_mdalam@quicinc.com>
 <20250410100019.2872271-2-quic_mdalam@quicinc.com>
Content-Language: hu
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <20250410100019.2872271-2-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025. 04. 10. 12:00 keltezéssel, Md Sadre Alam írta:
> The BAM command descriptor provides only 18 bits to specify the NAND
> register offset. Additionally, in the BAM command descriptor, the NAND
> register offset is supposed to be specified as "(NANDc base - BAM base)
> + reg_off". Since, the BAM controller expecting the value in the form of
> "NANDc base - BAM base", so that added a new field 'bam_offset' in the NAND
> properties structure and use it while preparing the command descriptor.
> 
> Previously, the driver was specifying the NANDc base address in the BAM
> command descriptor.
> 
> Cc: stable@vger.kernel.org
> Fixes: 8d6b6d7e135e ("mtd: nand: qcom: support for command descriptor formation")
> Tested-by: Lakshmi Sowjanya D <quic_laksd@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>

Tested-by: Gabor Juhos <j4g8y7@gmail.com> # on IPQ9574

