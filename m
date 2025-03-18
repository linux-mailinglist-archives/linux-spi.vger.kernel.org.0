Return-Path: <linux-spi+bounces-7198-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96606A6771B
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 16:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA8FE3B134F
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 14:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B783E209F27;
	Tue, 18 Mar 2025 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWyYDx5j"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AA51C5F32;
	Tue, 18 Mar 2025 14:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742309889; cv=none; b=ftaNt1BlLtCQVS7D71xN8sW8IMWoX51N2HvXe0i/fjFTUpwPwoHpSV/9jhl3j/h1eQFZoRGNUB6mkaNl9AAFL2pXGWwu/uZTLOkusWi9raYPOWnmiHEXpUikv2scCjESxPp+tt8QyfcBZ6MjSApono/BwvQqRH5feGxSJjaG+/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742309889; c=relaxed/simple;
	bh=jbuLBMlwn3W/8BDwYMS1vKOuinfk+uPw7WXEKRoPUss=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=fDkrhPrHHSoIOL/jyBnYjTsI+3RvHfJ4xpESs71Hz6r3ORkX3wLs/0kTiu8Xm0O8aUIXy0fpEldiLTfQ5+F0HQDA+n3+ThY79BIpELa8esRzxfCMRjPRjj0O7QHQ296Ka9BVkThKj79ceSIvi05I3VrBh1u+h7BkzAnsXSc8mx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWyYDx5j; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso34220955e9.2;
        Tue, 18 Mar 2025 07:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742309882; x=1742914682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wIYhiSbyjyMgqKSk2yPk/8dcvUtNJxh0D/RVa279Fn0=;
        b=eWyYDx5jbZ8xNrkjs7OLnmpK0Wh1H9r2GjcuVkIqDrSvYaGXkgTWk1p/DCVL7Y2/GH
         72LVDX8oecY8BOq8DyRgk9OzWkV1LRg3VAdBPF1X9Sv1TE5PLlMTGr59tTwSB5zmGJYw
         yHGKAhHE6gMTKC3ZBzxlMwfXgIHlkTHlQ5S8gdomEJ8NDUdgyM14NPLlor3VvJK9A7uO
         P9NNHbBDcdmxLEVpu5uGb9lsZwmzsH1rv9oP1ePTvEypj7S8SNS+nNz585l26G4cC/Oo
         8h/C4zvhGRLc45HSmEtljCVuM3wB2Rrl0X4o0eeWtg2lLP3SiGhIs26lN5BpiBy3ZHXq
         ukOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742309882; x=1742914682;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wIYhiSbyjyMgqKSk2yPk/8dcvUtNJxh0D/RVa279Fn0=;
        b=RCxcDm+tn+x18+S0nrthwVPyY97rLFC13EXIQRFgUTg6ep4jGved6qqYp1ItMNFz4r
         thDiADs4TCPPkO6vUDvC7a5CRoWoY2u6twdnRvQMdXKo1ZPzDVOgnmK8ivqJce+yhwAi
         XzmgUy8JLESu1jH2oUHMNqBd6x2L1eMBPJJFCGKWQDb0A7qHvGVb44+6dWbSRVLG4SZw
         9EKkex34ESoPO3u/mrOkZ3fpaTnDEaQJmza5DsJPGHfJJ041WTa3g302bt2QbW0fDecJ
         xpwPO7G8sgxPcqYN9psI8egg572TKtwI1FAn9Rk3t31ef1Hogx4RyjyTz6/PCzyrH0xc
         8qLg==
X-Forwarded-Encrypted: i=1; AJvYcCVYxGIk8mvKSSMgJrClJRLBHa/7g9Umw7S7QqkUdVXeipfPHxSMiES62qOWAHm4fqVy4+Nl2xsrWSd2@vger.kernel.org, AJvYcCXGwLJJVmwZm3QT1jO9xH4JUJZBMSKr+C2+uL8dYDqvktoJudRwQ3e0aHb2IDN5M7V2YBzunvTidjMduM4l@vger.kernel.org, AJvYcCXpFELg9DH22hb9nNpPThi3wY33xOr6fGFYboDqhkzkbPUQgShfWql3BhV36FFJk3hrkYxQMLbc5C3eJLmV@vger.kernel.org
X-Gm-Message-State: AOJu0YzJDSeoF2euULE9bwTib+IdpN12yZ3rLa3UZC0IaBBqAjwopXEi
	WWI38oILro6gBmHmNsN9mgH1GVlfRtlIWVT8LllJ4o3jsvgOUlss
X-Gm-Gg: ASbGncvgI6JQfF3wtQCh8yjrKgZySTtk/3+eCRsxeFY8WogYx1SRZ4R+h2EsCn2jpJz
	1i+FbGZ3iYry0iOXOPEDk07a5DfoYF1i6WddN/FDCk074mdXimpntaa+S+gR5q0gfZPQYUoBFe0
	JUgz8E8HNTzzrZB+l16yIcuLamPumYHFnvqVnbjWF0DmZ2RFrxdcQI80lwTyGTnDwgtY4pyUnJP
	5g17OhtY05OMiNeljfqIoeVAxtDPDl0YeYM++ZiO7R7k2nEX+lomSt4X/Bh95piYtEBYk9or9hK
	nWTMVxXcgphu9YBXwwf0ExyBwnX52HPOU1JFI2owh3XoIEIoViVcGuCNiht8xErMlbYr39Xrf1e
	NtIO/Dpcehg==
X-Google-Smtp-Source: AGHT+IHqIIsxhsxL4TFb4mT39GCDZautBu6ueHr8Va0JRlDgI6GhXcz9I1HKZ70r9nkSYDmiKVjgSQ==
X-Received: by 2002:a05:600c:3b9f:b0:43d:1f1:8cd with SMTP id 5b1f17b1804b1-43d3b9dc60dmr23405505e9.24.1742309882448;
        Tue, 18 Mar 2025 07:58:02 -0700 (PDT)
Received: from [192.168.20.170] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffb62ccsm137191865e9.7.2025.03.18.07.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 07:58:02 -0700 (PDT)
Message-ID: <a72f0db0-fd49-4cff-bffe-671fc757a219@gmail.com>
Date: Tue, 18 Mar 2025 15:58:02 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Gabor Juhos <j4g8y7@gmail.com>
Subject: Re: [PATCH v3 4/4] spi: spi-qpic-snand: set nandc_offset for ipq9574
To: Md Sadre Alam <quic_mdalam@quicinc.com>,
 manivannan.sadhasivam@linaro.org, miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com, broonie@kernel.org, bbrezillon@kernel.org,
 linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <20250310120906.1577292-1-quic_mdalam@quicinc.com>
 <20250310120906.1577292-5-quic_mdalam@quicinc.com>
Content-Language: hu
In-Reply-To: <20250310120906.1577292-5-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025. 03. 10. 13:09 keltezéssel, Md Sadre Alam írta:
> The BAM block expects NAND register addresses to be computed based on
> the NAND register offset from QPIC base. This value is 0x30000 for
> ipq9574. Update the 'nandc_offset' value in the qcom_nandc_props
> appropriately.
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
> 
> Change in [v3]
> 
> * Added nand_offset for proper address calculation
>   for newer Socs
> 
> Change in [v2]
> 
> * This patch was not part of v2
> 
> Change in [v1]
> 
> * This patch was not part of v1
> 
>  drivers/spi/spi-qpic-snand.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
> index 8c413a6a5152..85a742e21cf9 100644
> --- a/drivers/spi/spi-qpic-snand.c
> +++ b/drivers/spi/spi-qpic-snand.c
> @@ -1604,6 +1604,7 @@ static void qcom_spi_remove(struct platform_device *pdev)
>  static const struct qcom_nandc_props ipq9574_snandc_props = {
>  	.dev_cmd_reg_start = 0x7000,
>  	.supports_bam = true,
> +	.nandc_offset = 0x30000,
>  };

Applying the first patch alone results in the following error on IPQ9574:

[    3.596403] qcom_snand 79b0000.spi: failure in submitting cmd descriptor
[    3.596490] spi-nand spi0.0: probe with driver spi-nand failed with error -110

So this change should be integrated into the first patch. Otherwise, SPI NAND
support would be broken on IPQ9574 temporarily between the first and the
current patch.

Regards,
Gabor

