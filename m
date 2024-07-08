Return-Path: <linux-spi+bounces-3778-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8534E92A1B2
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jul 2024 13:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A909283C02
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jul 2024 11:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF9C7F466;
	Mon,  8 Jul 2024 11:55:24 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30E77E782;
	Mon,  8 Jul 2024 11:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720439724; cv=none; b=SLKtupYvYF3N+a/F5Lu0YlKi1mHh9Gly7dTx5RVHaH71i1dSlnKfHXns2AetdThOKQAPt9nLH8e5kQiCov9PAFvlXyDolq71lDiwIm5+KHz9uuc+EqOpnLjp928xrgCjhUfYGOUc9Z9TasT07yMvwrhljSdV3FH+y7DNWs/vDZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720439724; c=relaxed/simple;
	bh=lmhkDOhIMHXPVoUg/yUTlNILfZoYQ/UhEykIAf1D2gE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uM1oaHk1jtK8kOYjQ/VXOn7o0iLQJYHO03ubaGamCAcbKIxa+itciev5KhkhxyKvd+L7MHyEhH8ja362uPO7cmfJjQdoPPpS0ZhS35y6P0KqFehuGoyu5qp8SGyKKQz3ONt6ejq7B6BicNUIRhSfm/+6/7qLiyOzYKvf7qKkm8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52ea79e689eso3861054e87.1;
        Mon, 08 Jul 2024 04:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720439721; x=1721044521;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSIwQoL8dxz4do+5EdS4ls5R19CGVJVSGhVOJsTqOLg=;
        b=rVvRwdXiiOZCywUisGIgnWwy15PIRKir6pvk1vY2k0po1CHzRaRvPEgYnDZE0LII3i
         tk5QEncslX9pv+b/GMTwxnJnGwNOyRPl6Fk+g4PnLoRbCsuONGW+o6mozxx8vxRp9+z3
         gEpMdgLpALPBM23YEEc7+4S0sHeW01x7XnSLENmbfqFePngtNjCi5nK7ebtjZ1r3NlVG
         Wxb8o0T19UwBPGNPcd/t0xZls7isNlMG2p24OOYwSdcy9j2+h5pSlRMRQdT7FiLBra4R
         VKgnPG7gnSSctneqFVWjlWF4Eg7qE0Sw78npPL46wUTYrnEOySDNDWu/0Y4rDpA8KTNU
         TKTg==
X-Forwarded-Encrypted: i=1; AJvYcCUjD8jpeRt+pDRDtKbcchRiK3GiAQoXgi4fLw8O9G2EIELfmKfuqtRjNU8JJV/jkDwMidIc6tMcAQPWGMQR7SQ/NNdVE/dKlaLP
X-Gm-Message-State: AOJu0YyDzCEccIWmVD1Ni+Zm2eJ4cte1n38bm9dO4scd+AHCxwa6v03i
	6Tujkg9dPKiyF31DijKzM7CzNrmCy8xFU942Ujrnay73BKJi9SgP
X-Google-Smtp-Source: AGHT+IHmxmmoU7UVS1IsOUanJCYN38+DtdoWl+tL44zJMS7tO/LpmgDcY4lFWJvRNXTiuBcCi8uPAw==
X-Received: by 2002:a05:6512:4de:b0:52c:df83:a740 with SMTP id 2adb3069b0e04-52ea0632835mr10406712e87.30.1720439719729;
        Mon, 08 Jul 2024 04:55:19 -0700 (PDT)
Received: from [192.168.32.129] (p54ad9947.dip0.t-ipconnect.de. [84.173.153.71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77c3925a96sm337987166b.120.2024.07.08.04.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 04:55:19 -0700 (PDT)
Message-ID: <0344c279-a678-4ac9-b4b1-6601f5a5a1aa@kernel.org>
Date: Mon, 8 Jul 2024 13:55:18 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: add ch341a usb2spi driver
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <20240705145138.5827-1-jth@kernel.org>
 <aa3c79a0-ecbc-4f12-b540-6570350a7909@sirena.org.uk>
 <8a2467b9-4eb5-4ab4-a4c8-da37875fe4c9@kernel.org>
 <5890754d-50a7-4db6-a33e-bba64ca1389d@sirena.org.uk>
Content-Language: en-US
From: Johannes Thumshirn <jth@kernel.org>
Autocrypt: addr=jth@kernel.org; keydata=
 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
 roB8y0CnnX2FY6bAVCU+CqKu+n1BLGlgwABHRtI=
In-Reply-To: <5890754d-50a7-4db6-a33e-bba64ca1389d@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/07/2024 13:32, Mark Brown wrote:
> On Mon, Jul 08, 2024 at 10:04:41AM +0200, Johannes Thumshirn wrote:
>> On 05/07/2024 19:41, Mark Brown wrote:
> 
>>> No validation of speed?
> 
>> TBH I haven't found a command that reads the current settings of the device.
> 
> Why would reading things from the device be relevant to validating what
> we are writing?

Then I don't really understand your comment.

Why would I need to validate a constant? But indeed it doesn't make any 
sense at all to pass in the speed parameter.

Will fix in v2.

