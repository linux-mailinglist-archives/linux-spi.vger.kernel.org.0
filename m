Return-Path: <linux-spi+bounces-8542-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64899AD923E
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jun 2025 17:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9213A7EBE
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jun 2025 15:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B8D202C52;
	Fri, 13 Jun 2025 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtJvzLIU"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C351F463A;
	Fri, 13 Jun 2025 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749830204; cv=none; b=s7dNHHfALcB3fjZFo21Z+snAfxnH67wzp76pggtSIeW6b1VdA+//9+h3lqbawCtHsY7Tt+IEEY4fRbty/qUeSRb6ceBtdDq5o1P5DcwpsU162OLAlITNbnKwVmrKUgGSANwx4UTsxlpbPJJrMeDqpP6Qds6xRoSyIxtN6Kb7aFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749830204; c=relaxed/simple;
	bh=OwWwJMJMz1gVCx/M2Des8/aF3uScnadX1L2LxSc73zo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lia9isCdDn+IcmhDXLd2Q8vDRPSTI5AXPs4EZgDLbgPuPCZmBc+U41vrVvEqoPkdRbW/hKVcuiyBIkBcgVot/CkH7BeuPse1QyWWeXYqNBHAS8GPZnGI8H+1tvE0RTMl0aAT8DNWQaWgEigtIu+g9DagAb8GSOV9hLwnNOYdVvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtJvzLIU; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so17596385e9.0;
        Fri, 13 Jun 2025 08:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749830201; x=1750435001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPo6H/9j3Ay9teefhcqMxpNsx0jvAC7MjlPzeeLu5rE=;
        b=WtJvzLIU5z2gsfsyfs2NvE2Vu7stYrE5zg/WHTCxjLyuQODy45mMFrGEmc7kWcWLTy
         4R9qZwdcJRuvjWLR/fVHIbY5KrMRoiqiMBIbub671TSbcQBrFEsBM3pFNVy1LhsSFhFF
         1iJIgn/+b4Nxzl+F7tns8XM85R1tZSosw8Cntr1hUSk9rk2bhDX6d7y9r+plULrNpqO6
         WYIw/g/mSb9hCylllFa1ts6WPeyrUfRtoLWKtSRH3foSDLQAhGMa6hE52LMejbtbcBHo
         PJpgXUbJA0Lc7339r+XDHop8zPLqKsRVuPa+6aAO63MLhbYekKM+3PfNfosQG8IZqZic
         J15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749830201; x=1750435001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPo6H/9j3Ay9teefhcqMxpNsx0jvAC7MjlPzeeLu5rE=;
        b=jxybNoFOl3guTZDbva2/WThvZ54R6rfFHM2DwSyD2S4bQWrvGYOvXCVziyBZi5ZvnM
         6c6zwmDsfu8dUIr6tUoQnYEwp8Pya/XKaLReTYgz+LnQhWXzhMo1+ocOUPub+M3laYID
         iSQZ96xIq88DNdwIFDlPa8lc8DgvWZLcIzxIgLzP7kjBTpWWJW2scS/9tbc87KAY8ZtE
         t2m4IZzIW5Nfl3zIYn8wIf8xMGtnwtZkx6Y0u7HYCozfUWrh3RzHK2llgrYaEtmNDEXQ
         +JEe3+w4p23tajN03r3KGBedXtjIYBrCowpFk7rNtr77a94SMBMq6JPc1RhGsHAoSqWI
         u/Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWSEP5+zTleaWixrzwhYIf67HvXNynMOP1RT/1CkRKn+0jvbOPAM0tz0ZHqgX9zvOS2gC0mymwhKx9U@vger.kernel.org, AJvYcCWgGN6WcqZ6ETswc4EwGJpKE1Rb2M08EJAu2MQwaaciCXE2KbB453ZbfAeaux6CAYV+YwhXLyV/FBmTN8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxY9j/2CJotS7zs3tPLmEQJ0tSIwOlVrm5LqPxSdcXAbxgRP/Y
	xPIN5sIxH72QFEHwRiCaK97L4llA+q2ZEWiosXIp1+ep2s/c0r/0U5d3IlVRiQ==
X-Gm-Gg: ASbGnctbGWTI9LCzcVYddYEmZCxRUaVx9e1WXk+Dmv+nWOJbGXeH7eaQAYOU3No+iV7
	5+ab4dv9oATYRny7wtmQdtvdWApyOJWzNjtcHakYfosD3QtwzOTqIac44Gno6/yZTo2qCMkW4Dm
	VndF+WOw/OsUBjqTK61Lw/Pqki4IybvaQYULPD1dOgFOVE1XISO1jtL3mzddUuTg6BaPNumJyIU
	imP3lWXsJ2WJ7ieeUUL/U2SoP26qXsnk+MP4V179mvHmiYbs+UFaCh39Fhr+5gvKownTGr9N813
	6jLKLweAX26/ixmWTOShYv75Rza/BsnscwEybubodkjqpFEbbOqd4i8VolHsbe9aNDg/+F8PyLh
	/j++dBxWYsfSuBqOabKkOM8P/
X-Google-Smtp-Source: AGHT+IEek+xBG8qH6etYMJhHA/6eRULw+qWjFJ15S/9q/UV/dFart736CLdrph6JJHU+y3p0PfPeMA==
X-Received: by 2002:a05:6000:4284:b0:3a4:da87:3a73 with SMTP id ffacd0b85a97d-3a572e8cd82mr226657f8f.42.1749830200407;
        Fri, 13 Jun 2025 08:56:40 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a54b7asm2782895f8f.16.2025.06.13.08.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 08:56:40 -0700 (PDT)
Date: Fri, 13 Jun 2025 16:56:38 +0100
From: David Laight <david.laight.linux@gmail.com>
To: James Clark <james.clark@linaro.org>
Cc: Frank Li <Frank.li@nxp.com>, Vladimir Oltean <olteanv@gmail.com>, Mark
 Brown <broonie@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/4] spi: spi-fsl-dspi: Use non-coherent memory for DMA
Message-ID: <20250613165638.5d8ed000@pumpkin>
In-Reply-To: <d364667f-e0b1-4f1b-9034-2fadfd5d457b@linaro.org>
References: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
	<20250609-james-nxp-spi-dma-v1-2-2b831e714be2@linaro.org>
	<aEhMBsqlx9I4XqJS@lizhi-Precision-Tower-5810>
	<d364667f-e0b1-4f1b-9034-2fadfd5d457b@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 16:46:36 +0100
James Clark <james.clark@linaro.org> wrote:

> On 10/06/2025 4:15 pm, Frank Li wrote:
> > On Mon, Jun 09, 2025 at 04:32:39PM +0100, James Clark wrote:  
> >> Using coherent memory here isn't functionally necessary.
> >> Because the
> >> change to use non-coherent memory isn't overly complex and only a few
> >> synchronization points are required, we might as well do it while fixing
> >> up some other DMA issues.  
> > 
> > Any beanfit by use on-coherent memory here?
> > 
> > Frank
> >   
> 
> Presumably less cache maintenance traffic?

I bet it only helps when cache-coherent memory has to be uncached.
Otherwise the software cache operations are pretty much guaranteed
to be more expensive than the hardware ones.

	David

