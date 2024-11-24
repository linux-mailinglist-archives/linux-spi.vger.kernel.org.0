Return-Path: <linux-spi+bounces-5824-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 814A49D77DE
	for <lists+linux-spi@lfdr.de>; Sun, 24 Nov 2024 20:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 322AEB3509B
	for <lists+linux-spi@lfdr.de>; Sun, 24 Nov 2024 17:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8683136338;
	Sun, 24 Nov 2024 17:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HpgDD2Sf"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4FE84A35
	for <linux-spi@vger.kernel.org>; Sun, 24 Nov 2024 17:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732470891; cv=none; b=eXy/vFNHyIBAXEJUQHzJoyIwhvZqqaJMpyDHzB1103el2TxW5KheS7KMvkc02gsvkIO2bMaNRrJT5Opnlp2sW4z7fdlu7FDRSDQatZfr64TgdzlnqK9drrr1GOv1k78ZwI0KBq1xF/516vj8j+eyA5j34znzul4qOwhne3kaB3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732470891; c=relaxed/simple;
	bh=u3TXWFhwKMVr5dHjq1xqF/dSM8YPn22wGRYArR6i6YU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NaATZ9p2avVfL52fp8nE78z0Aj+iE6+5BxplJJP7AMKCaQ8srb874aMj8cGe+6CaxT/qc8RhoNfOuPQ/5Gl1oV54rlmGJ67evVxOeUpIzOiglzgt5+rAA33GN2U9+jOPYxDe3DUzfGAHkaUMs3TqaUm+ykfD2Lp3p2DQRP66gRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HpgDD2Sf; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-71d4adc3f20so142664a34.0
        for <linux-spi@vger.kernel.org>; Sun, 24 Nov 2024 09:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732470887; x=1733075687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u+1MYIiNsXukLktsJ3kzDAhdVZdxNNP2S76ANupTqis=;
        b=HpgDD2SfafYcZmaoSbV+jQQtGNFvr/AggpPH16v9GunZ7xsiflZeDDvkPzSbvMnlhk
         9P30UVbtwqi4PNo0NwYjXqwMRVnHmXbSRGBQVm5Tm0Yl+5whLn1EB73Pby9uTpHyo35d
         388d6ORZY9vFZaISAqTw2B2zNYF+cniKM8D/Ku/xEga5WplrT+M9m62IvqO7OVePa3s2
         l9WjaLGt9sLRrnbCU8t9PpdqOdd5cjM/CLYm+56xAJA9bd27WcJFJjfwy/71arCu86zs
         K9lEIGeXe0wgQlyqtPH7CWnMkLzf687NJ+fGyqk+3PGsqw3i46zpaaO4mwtfLrQotq4W
         YVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732470887; x=1733075687;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u+1MYIiNsXukLktsJ3kzDAhdVZdxNNP2S76ANupTqis=;
        b=K2e83VLmGaNVwllkvaPJwuj/cGggXzvWyA1jQFKSoQkSioKQL+Xc0tbg26JTDuX+Ve
         3EZ3VQTi4UPcybvvogcWgwcUoLQEHMzMaCJRusdQ6Z3bKg0E2v/5mhumupKJ7k/W9LT9
         cSvhFchVsT20k4kF3rS/HUKbLGF9lJMsEkDF9riIF73u11QyrtI5SR6KpLpQqdmHb/Ze
         ZBpcEt+irDPYCd7YIeLZS54AQaVYz6Nvv9T31w6l4aYiEucjtaUlV05TTRZjspR/13vP
         x2rUgYGxVi05aCwNfVVbgzo6QxhEPQK+MlNzin+yvOPnzuu1Tu+KviJZk57nsrfSgKaQ
         jKzA==
X-Forwarded-Encrypted: i=1; AJvYcCWUMhru91IQRQdnNAmN+CgyMvhARsQlYt/b+Sq97hiVVl1nGd17Fi5QfcQAqP2RGnwLFEfIBR2dfgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG66rDh+EyjG1itThKArWrZq6Ew9sIR6WXhTkqkmqEPbCsSaYw
	xDDHA1ULf5U3dGnJILGSoyUPUlypSHXqt1hUlvteRyXXyc1qT5s+THQhK6CENGA=
X-Gm-Gg: ASbGncsD6u2EKH9RW+hqAB0UiSIZUwC8AUZY0WwVvQCXf6uI4cO+uymXVJrokjYWEUC
	fjckdXjugPvHnD/Of3BjrjoapDcxHF3/Fcw2DCoxPw9yfBKzAPYttQJCs8WL25kmd+u5PqMXdh9
	k829auWPU3IDi0oNQsnymIw0+SDzqXBHklpjuJlHDox+XmHcCixPbnAKzQR2nbl3oz/KRG+C4DT
	CgpBYwovpD5siP+9hHWUpwKaQqrXdwxZx4dNMrx8UvqWlhsU+PBzRxtpv7A5I5vSYhzDQgqNh8P
	gu7I9ITGkJ4=
X-Google-Smtp-Source: AGHT+IG6boTMutiUiwpuHLxoB0K1Rz8NUqxPXZVoKB/0sbovewZAthRnt7xuqhCwvRGdFVJCtYsmnw==
X-Received: by 2002:a05:6830:6e0a:b0:718:9ad9:3082 with SMTP id 46e09a7af769-71c03b23ef7mr6267942a34.5.1732470887376;
        Sun, 24 Nov 2024 09:54:47 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71c0378fb78sm1708276a34.39.2024.11.24.09.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 09:54:46 -0800 (PST)
Message-ID: <259515cc-ca36-4dcd-b884-a9f9e3c2ab2e@baylibre.com>
Date: Sun, 24 Nov 2024 11:54:44 -0600
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/16] spi: add offload TX/RX streaming APIs
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
 <20241115-dlech-mainline-spi-engine-offload-2-v5-6-bea815bd5ea5@baylibre.com>
 <20241124165039.206dc994@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241124165039.206dc994@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/24 10:50 AM, Jonathan Cameron wrote:
> On Fri, 15 Nov 2024 14:18:45 -0600
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> Most configuration of SPI offloads is handled opaquely using the offload
>> pointer that is passed to the various offload functions. However, there
>> are some offload features that need to be controlled on a per transfer
>> basis.
>>
>> This patch adds a flag field to struct spi_transfer to allow specifying
>> such features. The first feature to be added is the ability to stream
>> data to/from a hardware sink/source rather than using a tx or rx buffer.
>> Additional flags can be added in the future as needed.
>>
>> A flags field is also added to the offload struct for providers to
>> indicate which flags are supported. This allows for generic checking of
>> offload capabilities during __spi_validate() so that each offload
>> provider doesn't have to implement their own validation.
>>
>> As a first users of this streaming capability, getter functions are
>> added to get a DMA channel that is directly connected to the offload.
>> Peripheral drivers will use this to get a DMA channel and configure it
>> to suit their needs.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> Some docs that need updating.  Otherwise I wonder if we should delay
> the _tx variants until there is a driver using them.
> 
> I'm sure you have one on the way and there is an argument that it makes
> sense to review rx and tx together, but still good to only add code
> when it's used.
> 
> Jonathan
> 

In v1 Mark commented that he expected TX along with RX. And we do
have a DAC driver we can probably add to the series in the next
revision that uses it.

