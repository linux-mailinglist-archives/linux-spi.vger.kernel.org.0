Return-Path: <linux-spi+bounces-7447-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3ADA7FF7A
	for <lists+linux-spi@lfdr.de>; Tue,  8 Apr 2025 13:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38D067A4E98
	for <lists+linux-spi@lfdr.de>; Tue,  8 Apr 2025 11:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D492686AA;
	Tue,  8 Apr 2025 11:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxHnh1XS"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A8C207E14;
	Tue,  8 Apr 2025 11:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111296; cv=none; b=MTZjxf7SmBI1fkJQtP0Q3YLwmfvccRPu+ofZ76WL7+R5UbcNrsg/wPveq6Ven4sj9bbPrVABP4QIKLHXt9TvKtc1bUxbvdt3bRD8DNW0nyKfbEfip4q5ZKgtyW1TidbLlU42dzcn4ESfuwdmvhC04IlPK2C03SAA4wdL6I1bZLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111296; c=relaxed/simple;
	bh=D3tSjslJEG5gUmYqPQBwZcslLuwSvruWXMArraYU17w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uByR9NP5NeiZepniLJK+Lk7siyzQMRoXc4c8YcF7qKKVdHSxD18kxboSi8fzT9AhlSrJmdNOv4cOlb07wtrdRV2ByNrW0ZFnSB+FOzVv2KOVFBuSKN7kKUDnRvlyj8w2XQbIKK0nNVYfmQUvHLYeqtMW3Ao2ec7xX3rCdOtlzV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxHnh1XS; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ad5236e6fd6so4888067a12.0;
        Tue, 08 Apr 2025 04:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744111295; x=1744716095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y1WTsXHcQYhNYnT0/xU5DpY+xWRau9JN7FZGJGxicCc=;
        b=VxHnh1XSzI9YwGM53/j8MvFtZ6gFE4ctmwZatm/1EhKFkgJ5iKIcpWvIw31+DIIRc5
         Zz/F0PlKWTdj1en4yCqKYzD9LLQrgUVKrgR4fVxxKxxy0pKszIxqlUHyuw1VqZwT+st6
         21mzN2ILVuIBKWz75izkNvltQ0lE9AFENpSeOPxYt8QGGBbp5Vv6JefDiVlCHQGN5uqy
         QD035zwP9ElPLq+5I54cBL1ZmM8lNHluoKViTslYBrM2mqgiGHATtzOhO6C+IDE5+pKQ
         NYtrZJVu0c9+m7ZUo95E+MpP+Y7oagGlwcH8/r17No6wn+erU1jInR0QFhq7MAfvtj2x
         y4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744111295; x=1744716095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1WTsXHcQYhNYnT0/xU5DpY+xWRau9JN7FZGJGxicCc=;
        b=rmWIGqftYs1vWvePDYsoYNl9m3i3Vyv5CeFTq1UQ7SdXTLYKU4YLjNMJGeKutO5Ni3
         6x7fY5JmuSaqxPL3XXsc2yf05iaspIo7ayEYj4gULCcVsl5tj1RHQ8hzS7w7fznHugRX
         kS12GQ8b+Vv5cBz/9kesa2K3V81gB7j842izm5WYFp0PKRcnLhz8DiU96fLM1Fjm0Cya
         0B9FCXeyGdyesvCzIEo+vnvPHNFQG07dcrts8CAWlHbkkAXQGEUiz7mMTTq+9mT3U3QJ
         qDkGHa1MIz6jPCE1dpz8zq80JEwZ14mZzgeLC7A7hEp6jS25EO2D4fG2cmRo7aknzvj+
         Ym4g==
X-Forwarded-Encrypted: i=1; AJvYcCUiMu9IIWzTZfrO/NM/YKSotZyW3P6+64T442CLOqBjnoCW1D9S/4OelXjK5ghDtwkT+5UlBVUL5Oki@vger.kernel.org, AJvYcCUku2xpFniyRyApCOuu6vvYz06Cclyi9MMeXO2xGRvcTDPojPqO90YQe/h5OkBms/KlrGj+l6Yf9zBkQxbA@vger.kernel.org, AJvYcCXsWhwwsPRHBtrtiAfNTWFkM+pWqCB1szwGFMsURhQj5PxtFRRT4GjFSnTpwNxUspINJp0Wy1MMEoYp@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg7cQJ/00N1kFPte2CbNLAu2o/5MiTwdv5TGYSzg17R/qOF577
	4XjjLQ9S2KT7ZnbJQG10xQjp1GveelkkE/setMzPESegM3rPseo0
X-Gm-Gg: ASbGncvDbjsABK4az0lDw3ZxrlKogMVdIXNw7MAJ3KdPeMAuZnI0qWVHI3GqtNaPkUU
	mBhFbI1BN1aVJ55ERG3F4r8qPfHbbrm22A4psK+BCmRASPWxULSFKboYOGh6JWuLQglwSFJdXwT
	R7+C+M4F2tM+SHpWD0BXNAJ9Dkc5PGVOkoXHIxH5+vuWL6S9X/HpiLx0ud/ITuD4s2hlnBGkheh
	zsfk3CpyetQtMeF0uFtenh8dppWjhLlaaRxRRorCx75+OyLYvBbeuozZniGDfVGxpVpeH2FP2xO
	oGQ773SpTbb76gioI+qKzSOM/fCx44e6KkIF56aXvvPIfgc=
X-Google-Smtp-Source: AGHT+IENHbT7aGSGC2d+Xs3HK0eW2n1NHcpEJC/0ogHOySPZcdktzD7ZPPAXmOKRs/wQ018ClqbpUQ==
X-Received: by 2002:a17:90b:53c5:b0:2f2:a664:df20 with SMTP id 98e67ed59e1d1-306a47c2e20mr24517484a91.7.1744111294119;
        Tue, 08 Apr 2025 04:21:34 -0700 (PDT)
Received: from localhost ([223.80.110.9])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30588a30974sm10619376a91.25.2025.04.08.04.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 04:21:33 -0700 (PDT)
Date: Tue, 8 Apr 2025 19:21:28 +0800
From: Zixian Zeng <sycamoremoon376@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Mark Brown <broonie@kernel.org>, 
	Inochi Amaoto <inochiama@gmail.com>, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, sophgo@lists.linux.dev, 
	chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, dlan@gentoo.org
Subject: Re: [PATCH v4 1/2] spi: dt-bindings: snps,dw-apb-ssi: Add compatible
 for SOPHGO SG2042 SoC
Message-ID: <qe4qhkbou5t24jccfrufvszsrbrwvj765y6jrj3bnhk2jnh5st@2y4hpbmujo3w>
References: <20250407-sfg-spi-v4-0-30ac949a1e35@gmail.com>
 <20250407-sfg-spi-v4-1-30ac949a1e35@gmail.com>
 <20250407140739.GA2174606-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407140739.GA2174606-robh@kernel.org>

On 25/04/07 09:07AM, Rob Herring wrote:
> On Mon, Apr 07, 2025 at 02:35:12PM +0800, Zixian Zeng wrote:
> > add compatible property to include "sophgo,sg2042-spi" for
> > the SOPHGO SG2042 SoC SPI Controller.
> > 
> > Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > index bccd00a1ddd0ad92b437eed5b525a6ea1963db57..94102d94ed5dffe889a8a11c1c637d466713c208 100644
> > --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> > @@ -88,6 +88,10 @@ properties:
> >                - renesas,r9a06g032-spi # RZ/N1D
> >                - renesas,r9a06g033-spi # RZ/N1S
> >            - const: renesas,rzn1-spi   # RZ/N1
> > +      - description: SOPHGO SG2042 SoC SPI Controller
> > +        items:
> > +          - const: sophgo,sg2042-spi
> > +          - const: snps,dw-apb-ssi
> 
> This and all the other cases with snps,dw-apb-ssi fallback should be 
> combined into 1 entry.
> 
Sounds good, did you mean conbining "SOPHGO SG2042" "T-HEAD TH1520" and "Renesas RZ/N1" together? But How about the description?
> >        - description: T-HEAD TH1520 SoC SPI Controller
> >          items:
> >            - const: thead,th1520-spi
> > 
> > -- 
> > 2.49.0
> > 
Best regards,
Zixian

