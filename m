Return-Path: <linux-spi+bounces-10496-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FD1BCA2E6
	for <lists+linux-spi@lfdr.de>; Thu, 09 Oct 2025 18:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7D224FCB56
	for <lists+linux-spi@lfdr.de>; Thu,  9 Oct 2025 16:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D481D220F3E;
	Thu,  9 Oct 2025 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCnG8vPR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446561F4631
	for <linux-spi@vger.kernel.org>; Thu,  9 Oct 2025 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760027037; cv=none; b=bY771wN2tgnO4zPl3zMtCnCv0ifjAp+w40UGthw16ZLDjQu2wuBKrjtMHO4rzbEx2+0AzR5ZBYsFwYqypc9onbzWy3b75oZefgPAgCXYK9mYw0qvIaENh4drGPVCzRxiM7LnPl6lqS19Bnm5JPW2l0y4FToOYpj8r3TinN823d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760027037; c=relaxed/simple;
	bh=eVvkeQWqrG4dYBffY48He8ILJTh8EX7LtPQhkX3h+lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHe0MlsSR17Loba+TVyZ+TlBOmhKiVkwSDImbBCY3cFucYBWI3BRs3zEvA+rzKrBw4aR5HITUzaKw/+fRBk+nTyiePsdAPucMI0bhW4VLwTJgVpKjbcX4NPO3NjKodrSiV6Qst09yGiGR4uYirPy8ceDgWjJzjNeoKqF/paKZl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCnG8vPR; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b6329b6e3b0so1662974a12.1
        for <linux-spi@vger.kernel.org>; Thu, 09 Oct 2025 09:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760027035; x=1760631835; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j4C1j3OOKsjCqjPjMDTFb2+CfJ4gki9Qbk/4PqhkQDc=;
        b=MCnG8vPRQYAB/sRTi4esoaO/JWYoy5ApLLqeX6QndxwVYySMVYJKfC4gJjO3FwPqSV
         S30/FC8jXscm2L1XPxnjUqDd27oc5xOjcOGAGIa/5BlueteWIktVI8o/v3dMZDbmDeF8
         z5AR8SUuVLUDndif6y1kd0i2+o7Wee/2h2SVC/9uVSGcm5WK5k7oueRP+T90pEh+XE4a
         1d/kTqHfwlX9LPsj0YGzfnpL06PNlMtzs7tRQTGQIyBbwtT+lH5U1pKcVbVIix5OkX9B
         3adjH2abP2vWlPTF0J3nPlLFMQsmVhism3zMR9wh1pzs/U7nQ3hoL6WTMqh4mJNEytzO
         UfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760027035; x=1760631835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4C1j3OOKsjCqjPjMDTFb2+CfJ4gki9Qbk/4PqhkQDc=;
        b=qO4IazF2DVlbGTbaD9jS8YfVAonaeJh3CMfiH2Dwac03VZA9vGl9u+krGyKQFl+17s
         gV7wZrvCohwwfX4pbBD3MTxQ82sQVN5expB6H5QSYxMzBqamD6jf29PFNPFbyvujL86D
         YrZsXnztgfQslP8kNOZvEb6evhP9N9JJKBujmL9+XLkfrX2NtYyEH86huSAe/UDibeMb
         zPz6cqKrRJLKUoqPKuyaVw+3ajZGUqOwiV1mJvgm+6jgN0Egpgr4QTRnoMzJ08wTmGFK
         TyTogJZpIp+J5s50GBFMmgHJ2Kq3qnwLvrdQ8DRpbEC1X705He7x8lkvf4SEVzDdhISn
         W2Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVPC8y1GBoGhjNlGUWDRkn1NFRVzr+3vlwjU9jZnsiJfzzLrmLluFBsfhzJr0fo2mKeSd/pYq8bBGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YydzBcLMgKTrwSXRNXHL/An/vT6Ocpfn8hLMjCw+JgDhiBMRFXP
	Lax7Q2fIBJ3PQ/GWa6aFhSqtUWzcziyba/AU+HDpgYCWeK4ypxcmLP8MWTYw33Yx
X-Gm-Gg: ASbGncuOzrz5olDq1Z6HGnfhmUczsDUMYyruaenCVm59GdhrsLWKp0Oa324eg9Oes+y
	xrM5O3AmF5p+rQDjWRKOfOW961+GOMvufgao2t1+P1CTRb5kZzqf5iP1HZts0C1G+yOhMMRzFBm
	kwySsMzgfkDgupDRt5Da5uIupIvqZkDnsa0pE/pKHfPro1+w9Dp8VRy96ri1ON2EoXkFMTKsfTI
	8sxxmASjCtMJxr+Gea8c704wlOK6V9Og5g/bbi5OePQc7PNTuMjrgMhqFyD5DX95dzv9q8skKd2
	7+le6AAxmdkJ6OBY5X7dEndZ86QC5wal3CJumQFVDodTjJqz/YRBCoylt8wwtA38rHzpaihOO/G
	1TW3e3LgBrM0S68GhRAjZwOG4rD6wTd73ZoKzeaVJRxUPozKDKFOV9DA=
X-Google-Smtp-Source: AGHT+IG5iTuS4lml5ybOjWvkOCPTHDj9ZrBTt/dnU/W0P0sGl3oiFllm8k9GBt9WpwjupCqN6+ivSQ==
X-Received: by 2002:a17:903:1a10:b0:271:d1ab:17ce with SMTP id d9443c01a7336-28ec9cd59afmr138719345ad.26.1760027035566;
        Thu, 09 Oct 2025 09:23:55 -0700 (PDT)
Received: from localhost ([2804:30c:b65:6a00:ceaa:2ed0:e81e:8f51])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-29034e1854asm33475565ad.37.2025.10.09.09.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 09:23:54 -0700 (PDT)
Date: Thu, 9 Oct 2025 13:24:54 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org, ukleinek@kernel.org,
	michael.hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	corbet@lwn.net
Subject: Re: [PATCH v4 7/8] dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216
 and ADAQ4224
Message-ID: <aOfh1puxPJr367n7@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1759929814.git.marcelo.schmitt@analog.com>
 <7e51e036ba930284c74cf42afd53b17d49093654.1759929814.git.marcelo.schmitt@analog.com>
 <20251008-penniless-tiling-9a83d4b4ba48@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008-penniless-tiling-9a83d4b4ba48@spud>

On 10/08, Conor Dooley wrote:
> On Wed, Oct 08, 2025 at 10:51:37AM -0300, Marcelo Schmitt wrote:
> 
> > Change log v3 -> v4
> > - Now only documenting GPIO setup to control ADAQ PGA pins.
> 
> > +    else:
> > +      properties:
> > +        adi,pga-value: false
> 
> I assume this is an oversight?

Oops. Sure, should have dropped that.
If the device is not an ADAQ (no PGA circuitry present), then we should not have
properties associated to that.

+    else:
+      properties:
+        pga-gpios: false
+

Thanks,
Marcelo

