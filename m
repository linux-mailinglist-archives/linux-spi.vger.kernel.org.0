Return-Path: <linux-spi+bounces-8934-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D799AEED0D
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 05:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37BE9189CF49
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 03:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EE21E1E1E;
	Tue,  1 Jul 2025 03:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LOXcrdkb"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB96078F5D
	for <linux-spi@vger.kernel.org>; Tue,  1 Jul 2025 03:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751341255; cv=none; b=LLvPAhGB4RzheyXcCEalYiEeJMbpYG36XWRc1SDMEiNZjzc8Zw2OtPHPNel2vkzUgoXqjxN2T4rGhfZHy/GVQwRKx0cZNUOwwNKzQXBLE2cBrVjN61o52ggQegWS5a5cv9KpfhVqIkxZXdq6sEnc9KHXffMlESAEa+tbROckZ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751341255; c=relaxed/simple;
	bh=lltCWcMI+ZEH+lqujNaBA2dHmDr8aLcEnJsmY/kR5KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDxy1ZyxzZNfFewMnxG4F7tpSkzbYnq9ZTSGyAqav8BdhWdJEkqxIxqGQbUiRrNGIa7z0XQ4cphrZFGGB+u9oqavupfCAi47lXEaf/oTOveBS2jHUk15/m22xmAt8mx9iQrXcJxm7Y3hKe5vJURT+otsmIAS47E8pAOlcmjXwcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LOXcrdkb; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2e95ab2704fso1892853fac.3
        for <linux-spi@vger.kernel.org>; Mon, 30 Jun 2025 20:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751341252; x=1751946052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QG8cttO2YDJI/Cbrk9rcT5943IALpBAonWAZbSd3z9w=;
        b=LOXcrdkblG1EUfKmQQlzpJvmlVrd6Ot1R+eGIO0+X1iyazY9cLB4luGOOtSdYYTluu
         QodTKpYk9XOmwzcuEaYVmbva54i2FD35cK+Vg2RRcyd6Hl53mFdhzHVs1OE2hdrBL/MO
         YWzCd9HMVFOPARi6Ce3A0s184qTAB4c+iXkTWSiLtfKKJDgPBAkX+/hprw1DvsKAzA2z
         pqKr8s0bkneI3I3teISv0Kk0iEM3bDqL6q/HcnNniZknSF203kI4d/SnfW+SuE/0ECHF
         je2+VMiHD0eGWJsc91KSqX37RocUYd1siR6ou+6sEyzjU0CwrNXyzuqXQYwmrrfB7KU8
         9K9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751341252; x=1751946052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QG8cttO2YDJI/Cbrk9rcT5943IALpBAonWAZbSd3z9w=;
        b=ZtEAEcMf3o/1Rz4sYiz2Fhr/BFZ19TTWnbRGwBfCAolzFXA1Dba3HBK0EWkFvLXfY9
         O12VGmeEdbQCXHPovsNpa9WFZWfyhDDWcSyjCs9NLKXfVi452ovgq8AO9LI+Aklqcr6B
         Q5WvyivrpSJI5gk7UpCsVhpGJuh38ljo8o3Ih2yOFmslUc7OlJ171aYqGXOTsDSvcLWd
         1wwXGkqQ3T4rbBPj8eBqHzifrAY4MVuc8bP+322QV3PnjDlJwsxIMAPuMslfzyGZwPhn
         Cf99F1Ab3eW5nNlgL0h0yjDx2QCzPWmcFJzusR8hid0/SUu3qWGCIOY1GqWTcKMV9zgZ
         AK4g==
X-Forwarded-Encrypted: i=1; AJvYcCUV5Gxm2zDc1ad6HXfOR4nREL4jiCUjlazb5aENDZ4sWJuuulkQZuD5VCB8HwZdokXnpjTwecPKgwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGtVUsAYWxy2E+C1e81htbY4yEIap/YyoIJ5bL/lexcYKvTPAJ
	HAsgEWNIgCSpjFjC0TEIgLyvPRDhA2oCH2ol9jNp5oIsy/2lMphcDVSuTDpCOYJJ4U0=
X-Gm-Gg: ASbGncvnBkkbxEJvyss5iYitKPkY+AbfFHIu0gejeqezhk8RRNIQUKfYDdkjs2/xXTN
	lUTF9gaVMOJurbgMEdHqFhj2mpRlthJ01wKBAL9sLBO9CvliSiSWH9ebCQWERo+dJrHcmLx48bq
	v+g4lCpSZap+o2MhvGZ/zEJdXGdeIMdZ6TDpzV9E/XWW+4uFxdUTw30J9eZeQl0JjKJBHdl+wmI
	yjNEQLvjbMTbpEeB1JK0BgYYmO69EpfCOMk+YblDwSWeijH8VSubowpbtLcIW+hQV55nCXHJNCS
	TfO3ve3ss6QnoMsulq+xuviHAyCKzAMCHLBHEtpcZWkM934W44OCU05WMcJixkuzdOVq
X-Google-Smtp-Source: AGHT+IHV923IELGMFRF52e3SyaM+jl37uSwZWCYEONH8sGFzelWcB5/MVGr/Hp0oCRgdjFXA2owmaA==
X-Received: by 2002:a05:6870:85d4:b0:2c1:51f7:e648 with SMTP id 586e51a60fabf-2efed89fddbmr11880176fac.35.1751341251915;
        Mon, 30 Jun 2025 20:40:51 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:fb67:363d:328:e253])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2efd4ea6c7bsm3018677fac.3.2025.06.30.20.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 20:40:50 -0700 (PDT)
Date: Tue, 1 Jul 2025 06:40:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>
Cc: Mark Brown <broonie@kernel.org>,
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"Gerlach, Matthew" <matthew.gerlach@altera.com>
Subject: Re: [PATCH 1/1] spi: cadence-quadspi: fix cleanup of rx_chan on
 failure paths
Message-ID: <612f64eb-ab8c-43cd-9f6a-e913cd5aecb6@suswa.mountain>
References: <cover.1751274389.git.khairul.anuar.romli@altera.com>
 <89765a2b94f047ded4f14babaefb7ef92ba07cb2.1751274389.git.khairul.anuar.romli@altera.com>
 <9f26f205-756e-4fcd-912e-bf73167be21d@suswa.mountain>
 <DM6PR03MB5017D9C650820B9A5C63C6ACC641A@DM6PR03MB5017.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR03MB5017D9C650820B9A5C63C6ACC641A@DM6PR03MB5017.namprd03.prod.outlook.com>

On Tue, Jul 01, 2025 at 12:39:24AM +0000, Romli, Khairul Anuar wrote:
> > On Mon, Jun 30, 2025 at 05:11:56PM +0800,
> > khairul.anuar.romli@altera.com wrote:
> > > From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> > >
> > > Remove incorrect checks on cqspi->rx_chan that cause driver breakage
> > > during failure cleanup. Ensure proper resource freeing on the success
> > > path when operating in cqspi->use_direct_mode, preventing leaks and
> > > improving stability.
> > >
> > > Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> > 
> > Thanks.
> > 
> > Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> > 
> > Mark asked me to fix this and I wrote a fix but apparently I didn't hit send
> > because it's still in my outbox.  Sorry about that.  :(
> > 
> > regards,
> > dan carpenter
> 
> Sorry for sending the fix on your behalf.

No no.  You did the right thing.  It's me who messed up.

regards,
dan carpenter

