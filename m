Return-Path: <linux-spi+bounces-7197-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BCBA676FB
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 15:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A9B63BC452
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 14:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F91720E334;
	Tue, 18 Mar 2025 14:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4KcUKzN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD4620E01E;
	Tue, 18 Mar 2025 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742309562; cv=none; b=Qlmnh5mij8mtrB11WbtJjNFII034UBbO0fL894cyUxEq/D4H0ZWQ8Bi53EF3tMHWrLq5o/XbVXo0GXiSpbP5TPKnQNkUMVq+gSaaMqgAgaUq0wBMdWT7vSpxxZrxEJwCyACAYtqgrJpABf1aB0WS7+8AjrR/z3/HsKF7vjjKWX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742309562; c=relaxed/simple;
	bh=pHBe+sI4FwoiGUFSRZcrNRgdkaL4FBzEE/Aou9VB2V8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=eKd11C9oPNG88i7k2jhbUx11zrTYrpo7z0tR2+VP7SI+lcbQlBCpbe3mcYOazu2e25W4DFuc8T5kdS526fxH8B6QLDd7xBK+Prr+Q7YU+569LcwOX+OuLbyIvkItVMvGBWOg1jcXilsXeBHmtFaCz7+KKsOzMFNy05nLm1bIeRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4KcUKzN; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso5292149f8f.2;
        Tue, 18 Mar 2025 07:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742309558; x=1742914358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P52+0oCRnVmD6adG2x2Zy/twFor9rxgj0GU1RvsmWOw=;
        b=Y4KcUKzNkiyq7ARGZrNrnrOrLSqB7cQ2NfdtoUf7TOEG4hAF9DFKvcoTijVPPuyGJf
         boWvU4CJL6H1ODldZtsY9+DkWyj1UZe3Xs7kPwYawV1TiRxM1cvmuFoAX3wX75X6QXkI
         NtD/8vz1Upu15C/xJ+9CufeeysSDSyxL2Ep87llZ1YX5tS5rOTNIQ8Wccj+kYabdxkUm
         xuwDDInKy5gOtYpvzUWxAw7EmlrW/97jn6e1t9o0qoleiYU9HUzKuFw2YLEfJgOcncIV
         dOPkvWA2sAjE1XIav3dV4v5Viymck0OcmPkwutfnzWInW9gnDyieJ4dfQvHUDa43MhmV
         goXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742309558; x=1742914358;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P52+0oCRnVmD6adG2x2Zy/twFor9rxgj0GU1RvsmWOw=;
        b=mc/APP1uWx8m3tLpkWjJuPpWD8JOPp2IF9tK1eLUPcI5VSptb62wz2DA1OSlrh/K/m
         +kNJekUeSf5uzfAIBCwouPFKxskvqKknRtl1M0f8bkSVZ9rcxn/dWiC1BtYFhj0GYVAS
         +eyJ/PmPQPW9sZPCW2DMYOk3Yp4A+aaGwSPomZNEIzioWHX1TzUL7p1IIcCMrz5krTXe
         lGz3ze6vBNADk0XtgV+V5/K/GPSgyDi9U4lAf/t4bRNs+tLymp8FzFWQ/J8vS92rdDg8
         3J5+6L9QTkY5ci7i14g4W7ZkdXQS9bRnMrj9D79wwhZ8YBxgCLIO+jjHosFB7k6iHSfr
         1hpA==
X-Forwarded-Encrypted: i=1; AJvYcCVIUQoWhtEVNuuZpubYtPwIGauX8fGBGSJEE/H2kHTtdtGHtJWBfPsSyE3HDe24qgey04KbGAaCkHeBqHZa@vger.kernel.org, AJvYcCW4/9k0XB1Hop2LAfUx0VhH+iYSBs9FKll7wj+fLwjTSzg8xW4R1KUEqM8lLZZT2cJM0jkyqlZpc3zy@vger.kernel.org, AJvYcCXlbn1rGQiqSM8zhjaZC+8UxLZBMfjgDKaBwpDchmZt7noluKk6V7J7IHGGkVDsY00Ogj3F0M4u+Bl4TWHx@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3PuRLpVsQIWZd1ablQ6Gn1vhLfkzcP39DLD1dXrB5PFQAN1W0
	n+jw6DfuXayBmqsvXSSWRQPnwBSHgyBPsycZgk2q+PqBf/WojXlB
X-Gm-Gg: ASbGnctwdZS3jhHHcIKEJB3AsmvYrv5kTO6Dx24kgTDlolWn9oueqjxIOnRGBTFOweA
	yQbiv49FUNNgZpaKl11v6CNxynzWs3M1cKZhI0hfgOq+Az6lSFOf6G02qTYM47OnzJ55aWWz4MB
	uS9TsKlqTCIkZfoT9WwoaWHofE2x0pzLnLvGKrdt5KEYuc27FR7aFnIxnsRuhQ72aIPUD8Hpapo
	GTl66trDZeXnlia2yQ9oKGEcvIKarrFkrt+kFsdQKqSLpKIju0ZRgMB/kTbAbJJB1bIS99dW0ak
	2KxsiF0cJA+Wi0n/7Jz3V6Pi86fXInSSJiLe6HRitkTf88XQXwsASIK4QrCvGq3+3LvWQB+djJl
	mk25hA30YEA==
X-Google-Smtp-Source: AGHT+IGQ80YKRzqbI+bYWzTgEHSqoRgS1lsMKKEEz74wAmHtbW5UtEjm/1W1j+K4zE1tY/NoaZQL2A==
X-Received: by 2002:a05:6000:18a8:b0:38f:4fa6:bb24 with SMTP id ffacd0b85a97d-3971f41160emr18927310f8f.39.1742309558233;
        Tue, 18 Mar 2025 07:52:38 -0700 (PDT)
Received: from [192.168.20.170] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cdafsm18481455f8f.62.2025.03.18.07.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 07:52:37 -0700 (PDT)
Message-ID: <32785a6a-3f30-4d77-b32d-ee70c459de1b@gmail.com>
Date: Tue, 18 Mar 2025 15:52:37 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Gabor Juhos <j4g8y7@gmail.com>
Subject: Re: [PATCH v3 1/4] mtd: rawnand: qcom: Pass 18 bit offset from QPIC
 base address to BAM
To: Md Sadre Alam <quic_mdalam@quicinc.com>,
 manivannan.sadhasivam@linaro.org, miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com, broonie@kernel.org, bbrezillon@kernel.org,
 linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <20250310120906.1577292-1-quic_mdalam@quicinc.com>
 <20250310120906.1577292-2-quic_mdalam@quicinc.com>
Content-Language: hu
In-Reply-To: <20250310120906.1577292-2-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025. 03. 10. 13:09 keltezéssel, Md Sadre Alam írta:
> Currently we are configuring lower 24 bits of address in descriptor
> whereas QPIC design expects 18 bit register offset from QPIC base
> address to be configured in cmd descriptors. This is leading to a
> different address actually being used in HW, leading to wrong value
> read.
> 
> the actual issue is that the NANDc base address is different from the
> QPIC base address. But the driver doesn't take it into account and just
> used the QPIC base as the NANDc base. This used to work as the NANDc IP
> only considers the lower 18 bits of the address passed by the driver to
> derive the register offset. Since the base address of QPIC used to contain
> all 0 for lower 18 bits (like 0x07980000), the driver ended up passing the
> actual register offset in it and NANDc worked properly. But on newer SoCs
> like SDX75, the QPIC base address doesn't contain all 0 for lower 18 bits
> (like 0x01C98000). So NANDc sees wrong offset as per the current logic
> 
> The address should be passed to BAM 0x30000 + offset. In older targets
> the lower 18-bits are zero so that correct address being paased. But
> in newer targets the lower 18-bits are non-zero in QPIC base so that
> 0x300000 + offset giving the wrong value.
> 
> SDX75 : QPIC_QPIC | 0x01C98000 (Lower 18 bits are non zero)
> SDX55 : QPIC_QPIC | 0x1B00000 (Lower 18 bits are zero) Same for
> older targets.
> 
> Cc: stable@vger.kernel.org
> Fixes: 8d6b6d7e135e ("mtd: nand: qcom: support for command descriptor formation")
> Tested-by: Lakshmi Sowjanya D <quic_laksd@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---

<...>

>  /*
> diff --git a/include/linux/mtd/nand-qpic-common.h b/include/linux/mtd/nand-qpic-common.h
> index cd7172e6c1bb..6268f08b9d19 100644
> --- a/include/linux/mtd/nand-qpic-common.h
> +++ b/include/linux/mtd/nand-qpic-common.h
> @@ -200,7 +200,7 @@
>  #define dev_cmd_reg_addr(nandc, reg) ((nandc)->props->dev_cmd_reg_start + (reg))
>  
>  /* Returns the NAND register physical address */
> -#define nandc_reg_phys(chip, offset) ((chip)->base_phys + (offset))
> +#define nandc_reg_phys(chip, offset)  ((nandc)->props->nandc_offset + (offset))

The macro has no parameter named 'nandc', so this works only when there is an
identifier with that name in the code where the macro is used.

Additionally, the macro will no longer return the physical address of a register
after the change, so both the comment before the macro and the name of the macro
will be misleading.

Since the macro is used only in the qcom_prep_bam_dma_desc_cmd() function to
compute the 'addr' parameter for the bam_prep_ce{_le32}() functions, maybe it
would be better to get rid of it completely, and do the computation directly in
the function instead.

Regards,
Gabor

