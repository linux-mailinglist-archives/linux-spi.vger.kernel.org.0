Return-Path: <linux-spi+bounces-10186-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE3EB8CA8F
	for <lists+linux-spi@lfdr.de>; Sat, 20 Sep 2025 16:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EEE8623009
	for <lists+linux-spi@lfdr.de>; Sat, 20 Sep 2025 14:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B234D2F60B2;
	Sat, 20 Sep 2025 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3SQ+H65M"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8F78634C
	for <linux-spi@vger.kernel.org>; Sat, 20 Sep 2025 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758379390; cv=none; b=FHkiKwSbqL+cbVr3Ffkz98G+l7KKgUDOcpDHvC3P2xGIxvQ7Rwf7g5T64TFtd5/P4dwY44zd5ZcZAXfdXYd4Swm14w1+smNgqRK2fzRKdt/9+jjCSs8l2FKN7L+IhZ/T7iL4kbbkEG1haimriC/UNHR1jEuP6iLB45p5GnxFT5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758379390; c=relaxed/simple;
	bh=reGQ0DWfCnnIVp/Nxw5dBkwic445/96e5CXDstaYNKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nMX93KQRUzNwLGT8hvESRw+JMaAQWS9wlKo9cTelvU7Xd0b/G59G9AzZBK49HfC5FzlurraYpaSKoWuuH4V76Yx2vMOSdYb9Q4WMW/D/TMUCd2iEF34R0U+Onwcc53jTEENElf6kxzmHqta2auC9Tjw040kc+PT0ZKfr4gzOiyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3SQ+H65M; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-74526ca79beso2799210a34.0
        for <linux-spi@vger.kernel.org>; Sat, 20 Sep 2025 07:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758379387; x=1758984187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/zr1FxzQeV23WAfXkGwnch/VhAJlzRpqociU7pEguSA=;
        b=3SQ+H65Mq7lmz1B5VG20x9Lq90j5XOP0m6A9igV9aIJktsX2S+XYfV8k40KiAfLXLI
         F4ynoVa80m9k1y+BFmkiBJDY++D1LOfVFsYh3SiDi2s09tmRoBKfgBoMC6JfNkaGNF6g
         zONNJcYhNQyRJjAz2SwfU+05xp9sLB3vkt6VNsYhrWP2jrdiotxv0kgfqXtz9iDTggUd
         wQgl5Hu1BHqzbKCvtsyEVkAY+zxaavsHVzrSRCKKOcw19LIHHJP5kqTH6EECU+ylMHAI
         5CNuh8Bi6BvwUP/cTwXTw5mtEd+v1sRXJxAbC12HV2/RjkkMVFh7Ef8GhLYhSjwLFk8A
         YDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758379387; x=1758984187;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/zr1FxzQeV23WAfXkGwnch/VhAJlzRpqociU7pEguSA=;
        b=svwJxvj1S47tH+IrvhwgVeqNu+PHK0UJETm+E8HcTcdYRUmabTBzmZWbPkZKfc6NHI
         Lz4npZ28QVhJn67C3P5INhRQuOq8NSL44TAsEuO01jYAFfw4ny8dE3bu9QS2a2ME+slb
         MVO1LesD8hhLxef+CD6oc0KixfuQumE4CeHpEyEuK9/IX0RXvdiT8WQk9B9KBx0imQWn
         sp7jkJUivi1qAr0oRKHxKksstV7lmeHl8Cl+Cmy9/PFu7y8yghELX2SgLuR7xFGX8oBu
         myUkBeHqGblCSYYmLVW3IyD39qNNjA8mqdFD66P3Wqh5bAjXeYoP3d8NCnWHs+6E7tg2
         IoHA==
X-Forwarded-Encrypted: i=1; AJvYcCVTAVikEogdZb3js/sUjYrC73ZF1KTwCszMwU/NmYIU4YaMZJ1ISjVS3GG5/cyRqWw+d6Z3XUDYUL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6QPCnwwpCI5mpYVxznVlbBiRIZEGsi4d8SoguTH95jGprmgj0
	cOogwYnLMoCETorzDJ43daUq0OmGE443fqJ8cx6fMIBFqeKmGDS+AMhD2+A/uhGyOJE=
X-Gm-Gg: ASbGnctaE3acdOM26d9fEWrB18Ya7qwQxCp8HseI1+wRBTBHKx8X785WIulUEW3pEQ9
	B8v0PqD0adZAir9i3T1unsC8MjEmQ9wiDT8fabveuuFDVX+WmEcKnjIXeGER/PpA3JNOF5Hgrus
	AcdrrEIEqFMcos4t7nEuXE64QTlhEzt3MfQdk3Xox8nnBswQltzRy5SqusVpzSypBsuMpq4EoKU
	2Ub+LAZ7aY0UIyhBPITidnChN1KBxUrRSt1oJsk0UnAptyHQhtxVPg9/x4aB//A4GbpHStuRyVP
	HBgIHIasWt4peys8BuMivuBIwjljsjVagYtk+UX+qwsrl+gdicwFhWEXxx7CC5yRA03ZOrxGzeq
	u321yTec7TJuB+ZNtDR4ziF76RisUiSdXtYAYZYXFnRyPqxWBSvNFO+rDyaY5L9CFsbLhMuOT3d
	k=
X-Google-Smtp-Source: AGHT+IFRMjIdQHCqLYdQqsM4bOgBkQvcyRd2wt9TOxoiyYemPs4kzShqexKQOBSerVYHshLpIqXW1Q==
X-Received: by 2002:a05:6830:6606:b0:750:69c2:365f with SMTP id 46e09a7af769-76f6e58bc30mr4230967a34.4.1758379387269;
        Sat, 20 Sep 2025 07:43:07 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:14ea:b68a:f92c:93c4? ([2600:8803:e7e4:1d00:14ea:b68a:f92c:93c4])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-625dbca6014sm2701941eaf.25.2025.09.20.07.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Sep 2025 07:43:05 -0700 (PDT)
Message-ID: <7021b57f-bad0-425d-a7a1-3a613a408a42@baylibre.com>
Date: Sat, 20 Sep 2025 09:43:04 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] iio: adc: ad4030: Add SPI offload support
To: Jonathan Cameron <jic23@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.hennerich@analog.com,
 nuno.sa@analog.com, eblanc@baylibre.com, andy@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
 marcelo.schmitt1@gmail.com, Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Axel Haslam <ahaslam@baylibre.com>
References: <cover.1758214628.git.marcelo.schmitt@analog.com>
 <da55c0ed6fe895dc84e79c8b64e5923a4851e58f.1758214628.git.marcelo.schmitt@analog.com>
 <20250920104251.3f7dcbb2@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250920104251.3f7dcbb2@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/20/25 4:42 AM, Jonathan Cameron wrote:
> On Thu, 18 Sep 2025 14:39:10 -0300
> Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> 

...

> 
> Just one thing I noticed today.  If nothing else comes up I can fix that
> up whilst applying.  However, this will benefit from review from others
> + the IIO tree is effectively closed for this cycle so we have lots of time
> to tidy up any remaining stuff.
> 
FYI, I have some comments on this patch I am working on but will be some
time next week before I send it since I would also like to actually test
this since I have the hardware.


