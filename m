Return-Path: <linux-spi+bounces-11467-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29425C7D4E7
	for <lists+linux-spi@lfdr.de>; Sat, 22 Nov 2025 18:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E1E3AA695
	for <lists+linux-spi@lfdr.de>; Sat, 22 Nov 2025 17:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3345C2868BD;
	Sat, 22 Nov 2025 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BC6y5zpH"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56980280324
	for <linux-spi@vger.kernel.org>; Sat, 22 Nov 2025 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763833503; cv=none; b=SfY/YqEVNJ+5KnPR8x/mThHfq+FQZsOoPdbYepIKMcchnM/uQ/Xwq0223fQvQTfCH+OyC5BurhYnlVqIzq5lcAs7EsDxIlvStZ+89fXMIu8hOfIXYSX9bCMf+3fPafa9mrtPzt6vykQCzcZk3ouaphlA9KTYyAbaDcuNGgdNO8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763833503; c=relaxed/simple;
	bh=hgq5szZw1cJQ6Pay5skWEdtBmkCCIRg1Ew30CGIykR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gJIXu1L9xJo5Zcvkx2lO8oRwJE8h6rcOFMvixUSOi1YbF0/vyJZ343wKKA6Cp9zwZDrEwrLSFEqZKoaD4f3QMHqVEMniKLK6khShpcq76w5AI32Vv0venh0kdToFz4XNo7nnolevVU8mJET9pSa3eDZJ3O9D1ZGAveYFV7+Jyi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BC6y5zpH; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59584301f0cso3258648e87.0
        for <linux-spi@vger.kernel.org>; Sat, 22 Nov 2025 09:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763833498; x=1764438298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sK2kUfLFdnAIPOfoUdBAt1ROupy0YOwlhfQRrIOHuz8=;
        b=BC6y5zpHqYSq+3JiOePT7fImpfyvyty5q005NKqHWdApdVYJNq8c0U25oSN/Y9bb/W
         mpWB7TpfZV5nwcZmc1HmFnCF4d9rv8MORNUp79KE2dFqwW16Q+Orb65spvVmXfKBT+Dp
         4H5SbuiJ9YHLiRzEFLJA3ZUSIxtJaK/j0M1nt0v7Ojkkb6XQ4W3YnmQJR7atHOcCyXI7
         SRWmmPh5XrTmNp4jGl0R9otYmiA0AfC3pEcEBz9igwSJWO67mfaqBo/O5bMSb1UyjJ7H
         cW0xllFsmtHRiDLBDD7Anmx3Ff3s0GVARoX55xo+0v0LqkhAIpYhpCXnjV2ubhoj35TJ
         BoUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763833498; x=1764438298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sK2kUfLFdnAIPOfoUdBAt1ROupy0YOwlhfQRrIOHuz8=;
        b=vpxmbKcWINQNhVzOxOylRENVbP2rveMR44s43vsyUL1B5qdU1ppBpXL9gTbkSBWRLZ
         StCcFsQyHly8ZjCJJ78c4+qcO4uhu8CnJdFrzTwvI7e6lNSYU5mWPTgiGmFb/RSUHyWb
         QUWopTayzJbdgfXj3Ue2vsjjxSTXix78UdsN7mX4wshE7xWVI/ycLrCFENS+audM9twk
         hhF8CrEminkLO9FF/FWr9Dy03BXYFPCQV5Gcp+aKCdqedpGqMezVCLcM/1SCjo99In75
         r6IRnuw1oCFuRjmd6y94G+h3NouhpXYrW8x+Ht0KJ54EdIdrkBSKQcWkI0GZqxEp6Tvj
         khAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhcUjLXfzyvxvmZ07rFBG3bFYo+oGNlODkNc04XjSadOVZRJl8JSgo1dQmqY7SXdwz3jgcfdTbZ6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyJvKPRxJw8QoRliLZl5/Ul+Wjj1L3U/XZTJuqa7VUMwN6/7aX
	IFnsxbSEMcGtJlyrz1kpjXNZyl8UtxFZniuyYD48gPPEPhpUMuToxYmu
X-Gm-Gg: ASbGncuBpNj+4NszYnBTxnPVglJj7Is7sOd5b2TW5J85o85dDdHnesoLbdd8UzGxnTe
	C+vEA2ZYa2JQSBhobWS5ptbBEO3dPjSfYfdadpErn+hC6dr5/kLYp5VyVZFcquQl7zWhTLeqn1V
	HpB5kTjvvDI01lv1pyyqcS5dDTVC9tTtjZx/RD8pgbv2wNFCVEJ8CjWogDxmB5kS5XupPW1ZaPC
	T0aqTuPCxqe3wIJfBqmkCulj77Cw79YZc0eneyz/TUxOgrpCXKFmJ8Ny1URQJioe61kGjF0qyoS
	UJgTYmcyNqEamYJWkrex6rqZHBOm+h8zrURY4O1Nun5jBOW2drZ5vhmxBph31atgXuLon1iGvNY
	N5aJ3FXeHbH+nOpXqGvxmEwZES8/2aM5dl4Pc1kxG3Fo61/+B0tpM9xsotxJJGem7ibw/bIr9h1
	YJaynm68YSdMt/rjW9OWdwMf4=
X-Google-Smtp-Source: AGHT+IEPmZ/ql8yWquej3EfMZ1YkbDrP2BJ1nc5Ebqoks1N3idwLrOnLQ4i2cbgU3+oONurcV1tlCQ==
X-Received: by 2002:a05:6512:3185:b0:595:7d95:eacd with SMTP id 2adb3069b0e04-596a3e9ebb5mr2220711e87.8.1763833498193;
        Sat, 22 Nov 2025 09:44:58 -0800 (PST)
Received: from [192.168.0.131] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5969db8d967sm2596677e87.43.2025.11.22.09.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Nov 2025 09:44:57 -0800 (PST)
Message-ID: <ac2fc24f-e554-44df-9c28-00ac12d41af4@gmail.com>
Date: Sat, 22 Nov 2025 18:44:56 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] leds: add support for TI LP5860 LED driver chip
To: Lee Jones <lee@kernel.org>, Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Pavel Machek <pavel@ucw.cz>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Steffen Trumtrar <kernel@pengutronix.de>,
 Pavel Machek <pavel@kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251110-v6-14-topic-ti-lp5860-v5-0-5b777b99a905@pengutronix.de>
 <20251110-v6-14-topic-ti-lp5860-v5-2-5b777b99a905@pengutronix.de>
 <20251119153627.GT1949330@google.com>
Content-Language: en-US
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
In-Reply-To: <20251119153627.GT1949330@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/25 16:36, Lee Jones wrote:
> You left Jacek from the recipients list, despite receiving some good advice.

If we're dropping grouping then I don't have other issues than pointed
out by you.

-- 
Best regards,
Jacek Anaszewski

