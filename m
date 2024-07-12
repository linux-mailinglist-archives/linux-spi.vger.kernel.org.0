Return-Path: <linux-spi+bounces-3850-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E36C0930173
	for <lists+linux-spi@lfdr.de>; Fri, 12 Jul 2024 23:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3FBF2829D7
	for <lists+linux-spi@lfdr.de>; Fri, 12 Jul 2024 21:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A51D49624;
	Fri, 12 Jul 2024 21:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="M+KXEAFw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B13482C1
	for <linux-spi@vger.kernel.org>; Fri, 12 Jul 2024 21:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720818477; cv=none; b=sqDs+yEBUJwhBADRt1VckuhpWHp9dPh7HHFz27f8nKOsfhIo5uPZttXtNHl/6H5FLiBYIsw6jvjy6JTvm8Eiz7PS87QXS9K1ohoC+lPuqfC6luLqrdZv/gMHRB//qPO5QcWEXUtpJXfZlmVJvVeXgdAwBO24wSzXsmN6YD9N05w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720818477; c=relaxed/simple;
	bh=7Cm88/6Mbf88RzoSxmJ3Qlv7IJR9YSotepXJlOAWIic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BbJZ4O+jIauuzbzRiOimQthOgx9mLVq6BbQob5R2IL8IvWTFUxXlb79idZI6xgqW+8eO6NMRYd+cOvVtHu+mxQYlsrTnGhl9Ehr3nhHLYTYo3A5uSCgM+Gtj0DonYKgoYWj6c9iBOk/9Ih1Yh6id+wV6QTw2ir5GA6GAD9IWyqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=M+KXEAFw; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7044bda722fso1419728a34.2
        for <linux-spi@vger.kernel.org>; Fri, 12 Jul 2024 14:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720818474; x=1721423274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fq4KkMj11vqcNNXM8EwtAU8v4pHupusWEImjez7Pt5o=;
        b=M+KXEAFwnDkvZpiCGJ1fZBhp+ECUJoLb+t8gUqddAEjESnorNvqc4x5Yy2ZzYdLqhu
         yErgtzqaO5hT4C+kbLqYPy8uWwG8o9NbqWHM7tQ5SuzB1B/zhe8AnLDHwgSnnFHapPdv
         9WpqEDpSul9u+Ut79lBDy/OPydoss4c2vieQ9SPLRrYJyLFsQlSGoNeqVx0H9mBdZ2FO
         CEHjw2pQnKzg2ae7NeUy3I0xcUmoJKnJ7gz3PMzTjUUnGLh7cWEQD0jIRLal5H01G0u3
         A75XB0EG7mJDIqBfjdQhNrRu/T5JnOev6OrLrFCkhwWOdYB7lXtZR8mt2Yu4UokMU8+6
         CVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720818474; x=1721423274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fq4KkMj11vqcNNXM8EwtAU8v4pHupusWEImjez7Pt5o=;
        b=CNjJ/+j8oqhfND7Xvws94wVr46maFhbvNrbCJ20Fe48EJCg24VeSRVLw057t57WCBu
         gLBT/Mlq6h3SNWOfSXkbJlSrRgpflc1uAzzzruabh3OWzIZ50CaKFhHE8DMcri+1Dpo9
         PlG6bQuVGJsN3BtSMttSipY2sat/iTlGpicdR+nkf5iPbtkkDolfH7S5abQaU2Ze2A+R
         gjFVp7cgYNgV+O5po5/2VqYXllxfHupETYXk8FxjP/I688+0GwtLc3ZS7sCnzPBehi3g
         ktcvY2MvY1OGG9aoBM3O711SLsL/OB+8xcnKmL1q03HV9fHC/zg5W16iFyYFtX8lJVsh
         opSg==
X-Forwarded-Encrypted: i=1; AJvYcCUFz3GLXvHRWibgOWrTW3yTGHfU8V10xVfgjZMq50qGE7NZ92odBoLX3hkOpHhQyRBqTT/qsNJ27TQ8bDD1o0KOX1qePeq/nyGg
X-Gm-Message-State: AOJu0Yxg+t4D6yNkLau27gcYMlZmvPcr1ZOuGy113ClrjQkWGwZBW3HO
	HXyIkqjasETVPJrWlqnAmDscaJRUCdTwSbsoRVnVnQvfWISBbN0G4TacYwoc49M=
X-Google-Smtp-Source: AGHT+IEoXuUJo/PhE68eMUnJlCNcQbocfp7ikjcwp+WLVN3kx8wks5LBo4mswSpy1LlRkxQBiHpZ5Q==
X-Received: by 2002:a05:6870:700e:b0:24f:d498:5e01 with SMTP id 586e51a60fabf-25eaec6da3bmr11467594fac.57.1720818474317;
        Fri, 12 Jul 2024 14:07:54 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-704495a9e0asm1130090a34.81.2024.07.12.14.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 14:07:53 -0700 (PDT)
Message-ID: <5d1f63b1-5196-423a-a967-5fb2d9fef979@baylibre.com>
Date: Fri, 12 Jul 2024 16:07:52 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/7] dt-bindings: iio: adc: Add AD4000
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nuno.sa@analog.com, corbet@lwn.net, marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
References: <cover.1720810545.git.marcelo.schmitt@analog.com>
 <98c82e0a2a868a1578989fe69527347aa92083d7.1720810545.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <98c82e0a2a868a1578989fe69527347aa92083d7.1720810545.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/12/24 2:22 PM, Marcelo Schmitt wrote:
> Add device tree documentation for AD4000 series of ADC devices.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>



