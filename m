Return-Path: <linux-spi+bounces-7147-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D95D7A60F05
	for <lists+linux-spi@lfdr.de>; Fri, 14 Mar 2025 11:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 252101B619E6
	for <lists+linux-spi@lfdr.de>; Fri, 14 Mar 2025 10:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BDF1F4CAD;
	Fri, 14 Mar 2025 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="STNXo0Ag"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23F81FBEB8
	for <linux-spi@vger.kernel.org>; Fri, 14 Mar 2025 10:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741948342; cv=none; b=t86Qbu8A2MGxlxdJz1Rqlm1SXcuc3YmK/kruYFzl+39MisXFv7L41L7oanlz198u9g7W5Y8R82E17GD32YgwJDM+iQqDTkfE/E8tA9YcTbJqyJo0xM1lRIyZ/ekZ3WqyMrTtg7dOb2scC2SnaK9abP/BmGNTMPCEq2MzwtFcbgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741948342; c=relaxed/simple;
	bh=Yyfk8X7hQAsUD9G+4fe4CzUE4boCyIRsCV8/4Z21Gnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=geDNj0W6TT9dNtHsS+nWFlOsGb6viA2apaOcot216sch0tccdofMlCp5ZwNbZd3+xaMTCJOEK+KRcy2ea6oBYh7X79amxoVtrVBExeNnAQoBy+xD/IiI0op3MSnwk41b4q+/hBVElwpd8j/w+Hi8yTI7sh/6eoKSNxNyHFrWF9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=STNXo0Ag; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-391211ea598so1160957f8f.1
        for <linux-spi@vger.kernel.org>; Fri, 14 Mar 2025 03:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741948339; x=1742553139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yyfk8X7hQAsUD9G+4fe4CzUE4boCyIRsCV8/4Z21Gnc=;
        b=STNXo0AgSPwzQ1wQ8bdVfLNi8q/ZVY8QolO+5GsaVANcVCU505ZVqI+P0J7vsDQ1bd
         f2M/p+oIUbG+RA1PBzvy5Xz4EeO7zVjsgdk3gylmoOsJDJ48tLX5lRV7xoBQugBAkW7B
         FWp7XVMRCrIJW6YybRWkfYPX+Y3HN4VHPjKlq+QaY925jmW/fIAJp9ES5gAGy4rrC1Ox
         NaTdJ8jZxywFdbL+2WnIaUjTFY2mbFsl/WwQF2mBykzt5Jy3eOmVsiZ3EXQfR1i2FY3H
         rr/09nl7/vTpB9cGD/Aif/eXuX060/RSuyXqZhi1mpeWqa4z8ry5CUxlIXhJSGi/RSZN
         9SKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741948339; x=1742553139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yyfk8X7hQAsUD9G+4fe4CzUE4boCyIRsCV8/4Z21Gnc=;
        b=tDJGkmQZky0msMvvFpUyuw6PwliwWNuLkizrWrfXmKYyPjiCLgVODlh6aSUuBYkwsd
         vmzXlb8/Plxs7sTyGb8+54I/BcLF3k5zXUamJ7DtRC5aRj4uLeXx1IkSvDkLWLi/DJwg
         v+X9nDFaA6g8faYmHvO6UsX/Okftp1EXJsc6RPlPNLym6O0n63mP2KnLy0O0hPMYzrZz
         qlrYbBvl6HKRzQyr/E2nybqoJ21nB4DNYuNLULT8dnXAOPjQ069JszkB7stLfDLNmgD8
         MA03kx5uy1iwAJQklI3r1+AsKeHlO4+5zxVnxUNcd0HZEHz81A6ZalamRV1UgOkWgd3x
         a9Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVoPsSu3VUhni24K/2Trr/b3o9Mqs28dwcyo9AfnMko0vD2hbnBhNd09iLJkKs3bJZKcBe1eFzqhew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym2wQTMsDlzxNEIGVgo8t5wRV1Jf8fxuP8G9z4SE2rF+9shN2C
	IUzrZqgx59UkyfYn+m/TfmI/X8TwMGNV1XvrUcGUI10Aup721iAnIdAAGvQ7bUQ=
X-Gm-Gg: ASbGncuN0/sAIDcyXTY4HwM2PacpVfkEcASj7Yw7MtkaqQj9EA3LpkRHrenQno9Ygiu
	ow+7q9C8a/T2ObsHpFFslpxIgPDedbWnbR4oilZE93wsG1c2INebG4qTwnpakTISkssWXq1SfbJ
	c/qUuf3f3G39tlcW78CihLvPeeLFpFsYnDehGqFpGQFU4a3YZ8tQcOhqKhzQpgrN1Ed+JOUb0XG
	GQMkCEaYBqVHmTyZ24WNif80EwRxq127xiZ8P1yBCmr+IgLgWvNXNzWAZFLDuhhP8/s09Bg1ZsA
	Up5D7a+urfdx/ybkhM7+FeYCwnvMdG2qCUfT9xTXEovKoUh73NzawA==
X-Google-Smtp-Source: AGHT+IFQjVlKEgujwjT3Ubb4Yh1tGhuHYN5YVyssyzA1D8nbQwTyPMooOvvwbBRT8zeEV869mWIwNQ==
X-Received: by 2002:a05:6000:2ab:b0:391:1806:e23f with SMTP id ffacd0b85a97d-3971e7811a8mr2006308f8f.17.1741948339263;
        Fri, 14 Mar 2025 03:32:19 -0700 (PDT)
Received: from [192.168.0.14] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df35bdsm4990546f8f.5.2025.03.14.03.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 03:32:17 -0700 (PDT)
Message-ID: <f5946101-eef2-4e29-9e44-8a591a9bd42b@linaro.org>
Date: Fri, 14 Mar 2025 10:32:15 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] spi: sg2044-nor: fix uninitialized variable in probe
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Longbin Li <looong.bin@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <d343921b-16b8-429b-888a-f51bb6f2edc8@stanley.mountain>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <d343921b-16b8-429b-888a-f51bb6f2edc8@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

