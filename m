Return-Path: <linux-spi+bounces-9269-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B738AB19CD2
	for <lists+linux-spi@lfdr.de>; Mon,  4 Aug 2025 09:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7471688FC
	for <lists+linux-spi@lfdr.de>; Mon,  4 Aug 2025 07:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7E6238C1F;
	Mon,  4 Aug 2025 07:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMojP73I"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E1D2E3705;
	Mon,  4 Aug 2025 07:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754293259; cv=none; b=PnjnT2qWrAz+8ehXNByTocbpzKf6yEoPz5U/dF3+jv67tZvaBDZOTxdhHu4GU+S7VVGIH0ZAGn3q5F2JkgMuT0uLFaEmqJ+gTv0Azlot04MokTO953mK11hwDE2ysmyLdLOcxKX3BhrAcKf23wNa4DYiUS0+LCix/Z/EjkIavtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754293259; c=relaxed/simple;
	bh=1hFosvsahZHsjYT5v0KNwCoQ9bYBe5OdUFMQpRJHE30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3gW4bHjIloZLGd4ttWVI+r1tyiSoQnIIF47YoeiIjOikpufS36UKmBOgsiZpR4yrZmtFgOhDjYe1nHHscoWlDCp/DEeuVVIt+5j4kQGcuYkzI3AqUZjS6Rjb2Wkw2b8Bhn3h/4zt2Szm1ep3iLB2rO4A73WDcSdw3MERN5Aow0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMojP73I; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4561ed868b5so26387805e9.0;
        Mon, 04 Aug 2025 00:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754293255; x=1754898055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hqcKaT7eQkyPHjWKdc7YMZtzFXM2RtYZ2J7ldHCt+mw=;
        b=LMojP73I9pWU94GTSQc65m5zoArWIfPYamuQV4CQsBZAf0lm1S1xQpqd0qZaItocU1
         66Due2uhteUB+Qfbw/CHyoMwW7rfnFrLv3xQvJGB8Go41ZFFi0Zt/iln0vSTTjakcmaf
         sal5jVStUKLsus2/9plfNDKagpIBTvEHmE2NTZDO5x/j2/z1243HPMfVT8LIYP3gwjUC
         VukJRn+9oISN8khhf80qHevAWbQIyUjGMDDVnzTXpvOHBbVYBXaWvc0LoJjmYOYWgDE4
         KSSnd3aQLTMhJaZKEdzvSDymwtmMJaBVAfLbwWtRo+oD+Ww1t2QDk0B56F6FaT891OeQ
         2bQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754293255; x=1754898055;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hqcKaT7eQkyPHjWKdc7YMZtzFXM2RtYZ2J7ldHCt+mw=;
        b=k25P7kC9kVRZs90wLJEIHLbaYxMBmUIx8VAh8RiSS9woFUaN9Gn06/wuDi5M7GrFZI
         kyeDXxpMVVDV7ykSH5wTnC3EOurtPQUudVOyoHouWYeOsEmiY/4jNjqgexaVKMmECHhq
         J0y/tVzM6/gLK2ErbvGtbIkFRB+CkPmsoVVe6hYwhmiUttIhr8ZHf+ZfIvVpewn4MJ1/
         ndOPQRAN9v/lwWlGBJOh7TTenNXFe3RJWLPvxu7vKmfKwI11J+QzNe+Oa1VQ+SyDgVA+
         hzuOJROvUbBuScEX9VJBXgEEUOrbJEdU5Ok8leC3t+xRIG/w02N7OkP5A+Z4Efn+z8q0
         onRg==
X-Forwarded-Encrypted: i=1; AJvYcCUQDSD00jRQzpxk7wkTmfkwsXW0KslbRMqt4z25R8yoQlG8zrtgRa4Re3AXtjoH1LNCwAGGfZJKQWFzKItI@vger.kernel.org, AJvYcCXdZKpfQvkYCBk3/dJ5Df8mSRe37jIddc9bP+4H1Wgp/wvWEytaoFzzSPh+Xed1rts/hQAmT4/S4pO8gQN4@vger.kernel.org
X-Gm-Message-State: AOJu0Yza+7NyPQzJj+vjPHqtY8ur+OB8fHwgPkpJJbVOzYLoLKQcPkir
	ZYbqeqbMhOqpvd5V9/wZ+/665ORgGoycIgxXP0mILLtHJqFke/NDodgI
X-Gm-Gg: ASbGncs3BXK4v4YjDmhc+FvU2K5OcfzbgfRSWjp0VhQPrGbTN/nvM1e+lT91YwdBGVm
	wmUsvKCrs+fQuc0z9v0DUtHj5e/fHwsUuRS0S4xT3T9qNe4ny12RVd8cN4e4r4YPo9tEaapUiMG
	rbP5POjS19/fldBsoZOkMivjYcMpofEZIK71VEpfNjP4G0VwN11wWPIEbAX9q5ksNVqpxxBt3mj
	E2mufxK9ogKvOcgPaVptDwNOa9LZkmx9hixwACsCKcf+FW6GLuX+j70KzcqP2K29KCn8i6Ckf8J
	CqHHqE8nuc9bg1qTpxUixGGd74qKQPewKpT2KOTPTaLJ5f4fTNBgCCl/yM89XQ//GB7Pqko+5Xw
	aS8xI3WP4aXhKJp+kWWG/i+XnHFGl0WEGY8gZsxeP4bSOKobrf+nbMBF+QOdSbA8=
X-Google-Smtp-Source: AGHT+IFaZRGYY+LVcJLGb3+yzvNqGobXgRtxAeFaCa1MEjST24PMX695hPY5+LjN6sz9970sBJdQsQ==
X-Received: by 2002:a05:6000:24c1:b0:3b7:96e8:7596 with SMTP id ffacd0b85a97d-3b8d94ca5bdmr5641955f8f.57.1754293255137;
        Mon, 04 Aug 2025 00:40:55 -0700 (PDT)
Received: from [192.168.20.170] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4a2f03sm14376922f8f.72.2025.08.04.00.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 00:40:54 -0700 (PDT)
Message-ID: <1ba00a38-7293-4f72-9aee-f87f41a3dcc6@gmail.com>
Date: Mon, 4 Aug 2025 09:40:54 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: spi-qpic-snand: use correct CW_PER_PAGE value for
 OOB write
Content-Language: hu
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Mark Brown <broonie@kernel.org>, Md Sadre Alam <quic_mdalam@quicinc.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc: linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250801-qpic-snand-oob-cwpp-fix-v1-1-f5a41b86af2e@gmail.com>
 <b2e4d6b1-25bc-4b2e-ae54-6588f1573131@oss.qualcomm.com>
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <b2e4d6b1-25bc-4b2e-ae54-6588f1573131@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Konrad,

2025. 08. 01. 13:08 keltezéssel, Konrad Dybcio írta:

...

>> diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
>> index 0cfa0d960fd3c245c2bbf4f5e02d0fc0b13e7696..5216d60e01aab26f927baaea24296571a77527cb 100644
>> --- a/drivers/spi/spi-qpic-snand.c
>> +++ b/drivers/spi/spi-qpic-snand.c
>> @@ -1196,7 +1196,7 @@ static int qcom_spi_program_oob(struct qcom_nand_controller *snandc,
>>  	u32 cfg0, cfg1, ecc_bch_cfg, ecc_buf_cfg;
>>  
>>  	cfg0 = (ecc_cfg->cfg0 & ~CW_PER_PAGE_MASK) |
>> -	       FIELD_PREP(CW_PER_PAGE_MASK, num_cw - 1);
>> +	       FIELD_PREP(CW_PER_PAGE_MASK, 0);
> 
> FWIW I'm just a fly-by reviewer for this driver, but the docs say:
> 
> The value is the number of codewords per page minus one

Well, the driver uses that differently even without the patch. See below.

> "NOTE: This field must be cleared for block erase operation"

    $ git grep -hp 'FIELD_PREP(CW_PER_PAGE_MASK,.*;' drivers/spi/spi-qpic-snand.c
    static int qcom_spi_block_erase(struct qcom_nand_controller *snandc)
                                             FIELD_PREP(CW_PER_PAGE_MASK, 0));
  
This function implements the block erase operation and it corresponds to the
documentation. So far so good.

    static int qcom_spi_read_last_cw(struct qcom_nand_controller *snandc,
                   FIELD_PREP(CW_PER_PAGE_MASK, 0);
    static int qcom_spi_read_cw_raw(struct qcom_nand_controller *snandc, u8 *data_buf,
                   FIELD_PREP(CW_PER_PAGE_MASK, 0);
  

These two functions are using a single codeword (with zero CW_PER_PAGE value).
So, it seems that in reality the CW_PER_PAGE value means the number of codewords
(minus one) used within a single operation executed. Of course it is possible
that the existing code is wrong here.

    static int qcom_spi_read_page_ecc(struct qcom_nand_controller *snandc,
                   FIELD_PREP(CW_PER_PAGE_MASK, num_cw - 1);
    static int qcom_spi_read_page_oob(struct qcom_nand_controller *snandc,
                   FIELD_PREP(CW_PER_PAGE_MASK, num_cw - 1);
    static int qcom_spi_program_raw(struct qcom_nand_controller *snandc,
                   FIELD_PREP(CW_PER_PAGE_MASK, num_cw - 1);
    static int qcom_spi_program_ecc(struct qcom_nand_controller *snandc,
                   FIELD_PREP(CW_PER_PAGE_MASK, num_cw - 1);


The previous functions are operating on whole pages, so those are using all codewords
within a page thus 'num_cw - 1' is getting set in the register field. This also matches
with the documentation.

    static int qcom_spi_program_oob(struct qcom_nand_controller *snandc,
                   FIELD_PREP(CW_PER_PAGE_MASK, num_cw - 1);

This is the function fixed by the patch. As it is indicated in the commit description
this also uses a single codeword similarly to the qcom_spi_read_(last_cw,cw_raw) functions
described above so the CW_PER_PAGE value should be set to zero.

Regards,
Gabor


