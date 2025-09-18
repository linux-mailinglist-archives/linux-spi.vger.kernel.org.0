Return-Path: <linux-spi+bounces-10127-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67814B85B85
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 17:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17751547F3A
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 15:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09C12367AC;
	Thu, 18 Sep 2025 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="XabrV3B0"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12A330F95B
	for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210260; cv=none; b=OnA4lT3FUGYa4fiWr/oPf1WSmk2bQTfFzco6Jjfz34TOxT8XMHrjsm+iOWS5dOm4SRFoTf1Z1qLk4ny/QTuKn127PH5t7LTZjc8+F0Psa1C+I6/XHGz4KCpnzfcc5r7TWhhq0+uRvs0N3rOryMIz4OogDv3rhQlBo8Yj6/fxJ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210260; c=relaxed/simple;
	bh=2Tb9OeqfqChMAE/bW8nihG5bBkS+86woGLLzweX2qi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BbXHHDxCL6oNKzQ8WhteeN7Lj6Ix5BS9DlI8WLzFmD1okmYH/2XiEL/0C6L85gLagHXs5rr7OnFBhdQXjaMm0o1OhW58d75V2O7ziz3i+IfIocltQcCYQwyjc7siqDluKZQ7o7VP5mN0ZpRagTnw6tdjg8d0U8aw4mXl1AozvbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=XabrV3B0; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-8877b60f7a5so43195539f.3
        for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 08:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758210258; x=1758815058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IYhrldrOGtsDoKDXkPai5Tm2eHb8T6uZE7LbE34+y/M=;
        b=XabrV3B0ZA6VlMwP4NAAScWUl9nhxuybX2rhH4pBIREmSP0sZIDpddahi3/9WNQUr7
         FznFvKJdUN2PnRO0CBZAAHMyFla/yzrpYVT53J5wEmbYWuNGOZdKuBhnpSa0Cpq/uV7u
         YDWFdBG6OS4nP9l53Epf3A1OuAltT72R4V5426eUkZyXhJkgnIHmmgi5iOoUliGllYlb
         4R8fcOz4V7zIyxsGGa4TPQ+//HmV59H0nDstoX0va4ynaAkPWVkuEbjtSUBXue0i3tLS
         dvZ5jbH44sWzJwwDFFH01Xz8jrbVP240yfqbPC59ggZ8dy/0czmdo4DSSYPp0chIXpxK
         WleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210258; x=1758815058;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IYhrldrOGtsDoKDXkPai5Tm2eHb8T6uZE7LbE34+y/M=;
        b=wryMYA3HGZfJektpQnbcI1LOJ42Bpyr3ylzj7SMPMbsctAkHhZt+2xl5uH+S9cpyK4
         5uiw0c8BRfnI33cnQDkDI39RwDuNrYQ2aTL+sO5i32bE9V4kIVToqMGA4PS3PUw7Nppa
         JdZds3MOW2HBoM2RWVABxq8PWgg49OJQOFa/RiCWB+xBr4qK+xa5DdtQSNhMVvlHNLES
         xqYPX0jgAmOwOn79NjLdc0XGZhhiBCNQ3ssZ/+X4BlgblnSBBuhBFOuLNJQz6vJJ1k5q
         /uNiEeky3YBp1PggqXCC8wOwiaTh5n/BLRADZsfeEY6ahLiwv49x9mLJFJaJ2KcjwiXR
         UQAA==
X-Forwarded-Encrypted: i=1; AJvYcCXIWJGqlXIi4GWe96ayTX6YhaVeNK9uzXyDSRhZEjJcoeixD3IM329ZtucwhH8hkisfKCnVpPkXsVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLf3d3SDsxogbZ/qS8r2ViCgTZA84nmyC4SOJiYT6wr3H7YqAr
	qGbmobeuCKXDeEHQ3o7kOoaTn1N5HmQsu1rTIthwn59HxiOayJFdURAWLp8T+QbSXAA=
X-Gm-Gg: ASbGnctkEyCGSftwEo1friBaDLqDXYMC4eJxZ/gXs/sEO4r1UahzQLMmMftDCvXdZ0C
	Zmmj2W/4+3NEKOFal1sd7S49tew1xAHQNyf3hxAF5tCKeeV9oo4vKMMdY/3Qb0gitnr9sJMaKby
	73ZZ1djuh8c1Pe6dKBA7cRnO99wBhEpdowHjeQxiYjyWAM3wqPnkfh9k8ArTAQNaMNC9sdCds++
	9QKo7GCrcbdrqSsSXCrCf0xw5wh/aLr9TxS+BHt2GOj+Tj4oMPrI6ivNc1pnT7N2t6j5JPvzXV8
	Fs8O9vMRiqHZDtspIexpeg5GyyU2nTCAzOGCnRbzpROpPSIgXjx/JVtPDXPmOysFJTrclvsPQSX
	8p1VNrDMXSOBjdP+qgaZ7Ib7AViMIgSngAycmExM1TcSVdQMdJj4iJVqqGAg/rK5VrJNXEyxvEG
	93K6vuEg==
X-Google-Smtp-Source: AGHT+IHyY949yC9PkpeT/QOBqAaxoqc0DHrnN3CUC5h5A0iVJ6RUW339AkYSX5xvq1CVEEDiEGOZ/w==
X-Received: by 2002:a05:6602:2c95:b0:887:50ab:5c8c with SMTP id ca18e2360f4ac-89d28b42cb0mr960281739f.12.1758210251747;
        Thu, 18 Sep 2025 08:44:11 -0700 (PDT)
Received: from [172.22.22.234] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d560d3993sm1050465173.67.2025.09.18.08.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 08:44:11 -0700 (PDT)
Message-ID: <057f2f54-c370-455c-95ca-83f97d884f3f@riscstar.com>
Date: Thu, 18 Sep 2025 10:44:10 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] spi: spacemit: introduce SpacemiT K1 SPI controller
 driver
To: Yixun Lan <dlan@gentoo.org>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, p.zabel@pengutronix.de, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250917220724.288127-1-elder@riscstar.com>
 <20250917220724.288127-3-elder@riscstar.com>
 <20250918124120-GYA1273705@gentoo.org>
 <034cecd3-c168-4c8d-9ad5-10cc1853894b@riscstar.com>
 <20250918143928-GYB1274501@gentoo.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250918143928-GYB1274501@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/25 9:39 AM, Yixun Lan wrote:
>>>> +	void *bufp = io->buf ? : dummy;
>>> simply s/bufp/buf/, embed pointer info into variable doesn't really help
>>> let's leave compiler to check
>> I called it "buf" originally and changed it to "bufp" because it
>> actually advances through the buffer (either the one in the IO
>> structure or the dummy buffer) in the loop.
>>
>> I don't understand your comment about the compiler.
>>
> for the compiler to check the type.. because people could even name it as
> 	u32 bufp;

OK now I see what you're saying.  To me, "bufp" as a pointer
that moves through a buffer; it would normally be initialized
to "buf".  Where used, "buf" doesn't change (points to the
start of the buffer), while "bufp" does.

It is an established convention, so at least to me it's carries
that meaning.  I am *not* using the "p" to indicate it's a
pointer.

I looked around for some examples, and there aren't a ton of
them, but here are a few:
   setup_dma_scatter()
   __cmdline_find_option()
   tmc_etb_dump_hw()
   dnet_start_xmit()

I'm planning to keep it "bufp".

					-Alex




