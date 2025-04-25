Return-Path: <linux-spi+bounces-7771-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A85A9D5D6
	for <lists+linux-spi@lfdr.de>; Sat, 26 Apr 2025 00:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D7574C2765
	for <lists+linux-spi@lfdr.de>; Fri, 25 Apr 2025 22:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847BC2957CF;
	Fri, 25 Apr 2025 22:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1TYpNMA"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ECC2147F6;
	Fri, 25 Apr 2025 22:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745621201; cv=none; b=emlpcpKNf+g6Vfv1utWcD5fSRS5muALsq5jVYOvgr9iqg2A4AzaXI5OaW8Cx2WS/oPyPw78MgBQFcT9PYT8RJnHe/XhdcUDy5cGpSFPcTmiV/y/MD16i6vZdezX1t9ow0o7odV9Spucd/I10Z/pZB6zN5+SNSbJtSF8L7N4Do8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745621201; c=relaxed/simple;
	bh=mqrro+vxZhjTZLSg80tSis2wub+LIUloe3g0FjU34k8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VEexe7Q8YECS6GLcbxfWZHp0nwGlwyN5xcqj0FJc1qexSXg8TW+i5eEB3whjj6WAeJZYdlDQwVBZvoU8pPRQJ1yMgtmGl6+HkjWFT9qnA9Qy8Gx1NN8ZqdmgHCV3pcFWVOc+ZNWu2fKTKySnBYfU90hcBzy+pfie5IQ4ylBJIoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1TYpNMA; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-47690a4ec97so32416131cf.2;
        Fri, 25 Apr 2025 15:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745621199; x=1746225999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Ts2LHLz4I7Y52dAaMUvDVUrX5c5MFwWvzizIevoXa8=;
        b=c1TYpNMAV2gVJmgme7STvRNOQgfaDuSPGr1/7aVm48GL0PKZzqwzQjXSINwn0Jz3lg
         TeydQgxchVeyUQy10N8l3Sz0vFXEYp8WW2ojMPXXc5rkLxoOt2wAW3d0Z52puBX2B89y
         xL73IrZWIJ3yN9/yaYQJ/i/zLduWlxJ3JBgLTzRvGuX7CO5M3lHk5m5Cz5N5xpu6Sghm
         jECK/xcI62l0S+M8AIxbCybSIC/y4Ra9olmwNjFZclv+CmpffqclkEhUj3ZjXomEVsNP
         O2lGrACpxAWdhvoEEs9KATfbSPezy/qNyXAzVGtT8osJZlSptmJk2ZUbZDDxY5ASfq0u
         SWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745621199; x=1746225999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Ts2LHLz4I7Y52dAaMUvDVUrX5c5MFwWvzizIevoXa8=;
        b=beLg6B+OyoeJRhSj6qDIKhejuVeewAfT+jkwmEU7bPTfjtrmfFCMMbLxSirQtr0dgU
         eQsBHQndGFUtFhMqPrtZwIGXLCzMqQEmEGQtoKjdeT8vC8BnKhx3V8rWaaftYw/l/mIF
         WoLOmmN2nckpCynRm3TsP7q3cug0kMyI1q7BZEm08+qJ9jEJb5jUjT+cgG+hUtH9Ukbb
         a3allJelbXa0jiUvZh2s0LZg+cXeHR47PsK8ar9jpc0wxhBGtetEa/ltrOUr8c4CRiP6
         WIMt9Bl++P//VYHCxl9yJl+9smZazxXJgtqVi1QfvZ5jkM28fvDsVee34JqcT0rxcnWw
         /42g==
X-Forwarded-Encrypted: i=1; AJvYcCUzSVfNazTlmrnOvsluvOSvcYFjELmrlwam5WIwU+lyJJu1889i6nVGjafqnB3VLyIHC+21qVX+4gr8@vger.kernel.org, AJvYcCW8UZvxiLo2JAIOEho/0TEhqwbVtcPYKkCA9tKhLDwesgitSIBHOjw0AEZ5lWTlSndBkg7tR/bbQJ+Jm9XIjr2mCm8=@vger.kernel.org, AJvYcCWMbm5IP1Th0nUHZKXO5AYR2i1clAO13J3Sp77Z7PR22LsYvnaz5he13puqXAW7EQfB73/nIW2Q1FOvSGcq@vger.kernel.org, AJvYcCXZ6cDAVFQlD1ynWze92OC/To0K5LNqO7+hm4i5+JW4GL6ayw5BVbdvxO8mjBj4asQYI4Z8Yo37LgXy@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/KwQtcyQ674zvvSCGsTruGEHuo2tgvjKPOJ3mXv2iLgnca+f5
	1vARzvgNi2JjC5ISl4uGlHQGID+NuG1k9V56+LE/AFLfIoIm3TE4
X-Gm-Gg: ASbGncub8F7FDNj1KaIFC4MCYzV6B4/X1PIwi1f869kQCYvhYJOc1I3gdMjEE3m06g9
	wgY4Wn70BGc3da613VFJt51IFkOFldm9tTs43hNZ5M9AgQTxN14O37+p3OSUBuQvwYo+c2X0FmR
	6dPbwfHLq8bGFDsUQEg5TsXcamlsrKZPMrWeBDsV8j4l/Djdi2aIUf2RV+B1no1eXVDUvWy3l1n
	BRSwUfeBXmCAtel3EyuTAXU+uFdk3OyEq4/NaEpbnbuxqJmay4l4iOLEuovdZneAAH3NNv+tIi5
	UuABip54CqRT09mn
X-Google-Smtp-Source: AGHT+IHFMnb3Dv8ueG3yqBlwgHCe8l9Ust4EP/2O6HiGpIC9Wsr8B1BoBXzzFa/o+yntyw1+DEItgA==
X-Received: by 2002:a05:622a:44:b0:476:653d:5aea with SMTP id d75a77b69052e-48022c311f2mr71095971cf.4.1745621198814;
        Fri, 25 Apr 2025 15:46:38 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47e9f7aade9sm31608541cf.40.2025.04.25.15.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 15:46:38 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Zixian Zeng <sycamoremoon376@gmail.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	sophgo@lists.linux.dev,
	chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com,
	dlan@gentoo.org,
	linux-renesas-soc@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v6 0/3] Add basic SPI support for SOPHGO SG2042 SoC
Date: Sat, 26 Apr 2025 06:46:24 +0800
Message-ID: <174562116075.44155.16153568743582416091.b4-ty@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425-sfg-spi-v6-0-2dbe7bb46013@gmail.com>
References: <20250425-sfg-spi-v6-0-2dbe7bb46013@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 25 Apr 2025 10:28:11 +0800, Zixian Zeng wrote:
> Implemented basic SPI support for SG2042 SoC[1] using
> the upstreamed Synopsys DW-SPI IP.
> 
> The way of testing can be found here [2].
> 
> 

Applied to for-next, thanks!

[3/3] riscv: sophgo: dts: Add spi controller for SG2042
      https://github.com/sophgo/linux/commit/ae246f5c0ce444e5c964aa3a7d2d14a6df9153d6

Thanks,
Inochi


