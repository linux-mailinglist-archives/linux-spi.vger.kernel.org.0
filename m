Return-Path: <linux-spi+bounces-9268-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9627B19C5F
	for <lists+linux-spi@lfdr.de>; Mon,  4 Aug 2025 09:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68F943AF5F6
	for <lists+linux-spi@lfdr.de>; Mon,  4 Aug 2025 07:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD87233D9E;
	Mon,  4 Aug 2025 07:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nW5lpMif"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1D022422D;
	Mon,  4 Aug 2025 07:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754292133; cv=none; b=M8PgEB6PZqVasvDTcKwK+i123XIDtq1rnJPzhugojQYHTn7dTT1riy82cCLqWC8PG+Ez6jqWL1qCxy5qpOvV/8PQ0dCo/we1XP8u3lFZoOZ6Uh0QcZpWz8wsJY17tY6OCLxSIyZaRr/bz4zAoRd3Td618YkVHRWtOoh8ZQwERIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754292133; c=relaxed/simple;
	bh=Xb9hOeo9aGJTIzLhS44iafrxkqeat/Cuh/z9yhkyMvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ID2zA0Vt/e9Bob/Sv38/oMFYLhjtj4A5RkSTtkhy5Uu48iSe8xylIRlLXjoiyWYDAy4JTQPQKV0ee9dmZckwt/X76kSOzyghTsflW6l4YLGhdoe4mMd7k4TlDtwiz+rHc6AXB7mjZw281qbG6IhF73uV4Dl0F07nE0o8lVYOmhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nW5lpMif; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b78d337dd9so1775218f8f.3;
        Mon, 04 Aug 2025 00:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754292129; x=1754896929; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ToWpAUJRSlOUvTwmpX08BwtyoGhLc81qka+ZxJutB6A=;
        b=nW5lpMifAuJ5HZ8fEhUqLeaC5qC/hRXtLs89T9mYY6oRjnaLXrhV07TO6zT27lMBOh
         PbZm09wgczpTc3Z/yIXqmLSwXLpY6/MZh9wrfrpN7e7TeRfblzKRxIzky7CUoZELk8gW
         JKz4Z7V0YJm/5lb5xfKL0n0Bn7Ve1tlLJVdLDAYPLdgVcSN72OYr+8aVKXC2kuibLYcG
         EquDsz5QFIWXRRAhD7HETP8mzImMl1rIwAhK3zT/lOBoVJ/8eGXvLp7LyNwmRRPPH7MS
         Nep9+IsRhToqfEy4f51fHiF9pPuHabn3DLIUPzRCjX8ujOh/XoXtdpbrQs4e/cpTbWV6
         JRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754292129; x=1754896929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ToWpAUJRSlOUvTwmpX08BwtyoGhLc81qka+ZxJutB6A=;
        b=kgk5k+kuBZvvxGb3m5t7YB1EuVPJrvlQdLbL9qCTb8z7JlwpBxfbtWHdzS5urIjDnU
         QbLe0qeX03Cc1fS9c+SJCpjtNWVyLe9A8hd49z/QYS3zzaa+rFfipaTd15NLiJEC+PoT
         3ssTK0pBO+iRODnt5ZTJliMhQAJ01WCPnSFFKbqaDJXMt8OaQ7Ap9HPsZCdZcpq+Rlcy
         qaWnV8PV/2/SiekF/Xb59iNxxPg7wd10b43P0IObRwsEj1IWE0bvxJKLM075fkydIuH6
         XPOfJeUUvotyWv0c1lHrIxOiznIw7v/Zb5aufhu8WkfCihsdcnIb1dkxGUbD6HhfPIhY
         3T9w==
X-Forwarded-Encrypted: i=1; AJvYcCWhivp2eKvpUpRM3hQ58tD00VnDhfXBWAxH8FXWN1xCDw0n3/7YKu3J/zjixAjjrwp75KtNn8YpYarc1V/j@vger.kernel.org, AJvYcCXwmfoXtpGBRz9+YQiDNYL+tEvrFeplv7x7f+qOWNNTKc2o0Uy3gKqHFZuQskuGCuscNutteFGO3ImZ/zrF@vger.kernel.org
X-Gm-Message-State: AOJu0Yzne4ouiMyPJhvNW2A/TQudaGGKl8/8Q7/679wRMqKjMYZ9ye4K
	gH9yK4g8a+OgwFF6dsKI0mnfGgo09qNKgn/P6VfQzV6z7kUb7nJXf8go
X-Gm-Gg: ASbGncvHqT4+qg0AQzC/A1Uv3P5V+CF47Ji2FhiCeDMfsc562zMDPr5agloTo1pORvG
	dli/I8+6hUjHHRE51eYCH9M+wmAZrobIquLIac84BHrHbatuZLQnwFIKh4kdYQjvo0vv8m5f52B
	7lS0Mu4qZG8vktBSRw19OlRsnG+JO01bqc865PlRqQnNouzQ264emaCA2OjYYGhWk03c5uUcw3/
	QI9hitMHo/GgrrEVCx1zaIOTLikRNoH/M4zw7q0qBRp3EcujiqEyHA1WsohUbYS9zgwsJqQ/ISs
	gU0cW08f1ofhV1oXYzGbXFYrfFFt3ZAlni/ndDdPQz1FPlL1eOxyKIxL6RcJtJ9Kl6OPjYSqHDQ
	m16eCxrXPgRD8MXNbLYKwQaCa6sLPwxrTONErVbvvj9kkSPv+ptg+TTJduBOP/3o=
X-Google-Smtp-Source: AGHT+IGN+j/w75NGzay/OrfSDwoiaEeGnTdHqWBDbn2s7sF60e0yl2YtMKOnY01wt8RaPjdWxl/lOA==
X-Received: by 2002:a05:6000:438a:b0:3b7:926f:894c with SMTP id ffacd0b85a97d-3b8d9470d35mr5987067f8f.23.1754292128660;
        Mon, 04 Aug 2025 00:22:08 -0700 (PDT)
Received: from [192.168.20.170] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589ee4f089sm164855595e9.20.2025.08.04.00.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 00:22:08 -0700 (PDT)
Message-ID: <8883471e-57b9-4492-8d4a-aca3b4538682@gmail.com>
Date: Mon, 4 Aug 2025 09:22:06 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: spi-qpic-snand: fix calculating of ECC OOB regions'
 properties
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Mark Brown <broonie@kernel.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250731-qpic-snand-oob-ecc-fix-v1-1-29ba1c6f94e5@gmail.com>
 <72d5f805-1637-4c82-af25-e78b978c5799@oss.qualcomm.com>
Content-Language: hu
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <72d5f805-1637-4c82-af25-e78b978c5799@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Konrad,

2025. 08. 01. 13:56 keltezéssel, Konrad Dybcio írta:
> On 7/31/25 8:11 PM, Gabor Juhos wrote:

...

>> --- a/drivers/spi/spi-qpic-snand.c
>> +++ b/drivers/spi/spi-qpic-snand.c
>> @@ -213,8 +213,16 @@ static int qcom_spi_ooblayout_ecc(struct mtd_info *mtd, int section,
>>  	if (section > 1)
>>  		return -ERANGE;
>>  
>> -	oobregion->length = qecc->ecc_bytes_hw + qecc->spare_bytes;
>> -	oobregion->offset = mtd->oobsize - oobregion->length;
>> +	if (!section) {
>> +		oobregion->offset = 0;
>> +		oobregion->length = qecc->bytes * (qecc->steps - 1) +
>> +				    qecc->bbm_size;
>> +	} else {
>> +		oobregion->offset = qecc->bytes * (qecc->steps - 1) +
>> +				    qecc->bbm_size +
>> +				    qecc->steps * 4;
>> +		oobregion->length = mtd->oobsize - oobregion->offset;
>> +	}
> 
> How about
> 
> if (section == 0) {
> } else if (section == 1) {
> } else { return -ERANGE }
> 
> ?

The current way follows the implementation in the qcom_nandc driver, so it makes
it easier to compare the two, but it can be changed of course.

However, since the 'section' parameter is an integer can we agree up on using a
switch statement instead of multiple ifs?

Regards,
Gabor

