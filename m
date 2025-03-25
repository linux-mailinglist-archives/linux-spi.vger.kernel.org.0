Return-Path: <linux-spi+bounces-7298-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6048DA703C1
	for <lists+linux-spi@lfdr.de>; Tue, 25 Mar 2025 15:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1412A1887A4B
	for <lists+linux-spi@lfdr.de>; Tue, 25 Mar 2025 14:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544E925A2B9;
	Tue, 25 Mar 2025 14:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BvXM8LVe"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973422E3382
	for <linux-spi@vger.kernel.org>; Tue, 25 Mar 2025 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742913182; cv=none; b=W0HBYnzEYcuWmQIwFYXStTsvXj9XwFAcDSC1V/LycOfGFgKhLeB87iIiIZR3eIRViEwPtYGI2wSCvO7TT0AAMpb/SsYxz+quoHjR5YECrsmtfFCHD0yeHB7VoVbIaPrQ6Sh7Uflyl1BMjWW0fkFbCutUOO+OMEbVtZwK3yACAQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742913182; c=relaxed/simple;
	bh=m0zKd5ydXx6oxCg5WUGcqC9H5SeZXiPlfiQFHbhUVtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dS/LWIljQL32cQ+xarpUCn24k7Ne7uffQpyZ7lBEq+sbMen4DDMq7QC5iofwZ/h1J+5VFGgjfc/bDGGjNJUAPjYzej8IGzKoL2nzSCQgav7dMwzVNYAor7kk4aKQQOXqwyZ8u0KP9jhkmHPuEoYkCCccWtmHUPKBR23T2jCN6pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BvXM8LVe; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff799d99dcso9528944a91.1
        for <linux-spi@vger.kernel.org>; Tue, 25 Mar 2025 07:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742913180; x=1743517980; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OKRABh44uDFI70lZVbe1fR/gjcdCuWiPeTV+hZF44Lg=;
        b=BvXM8LVeE/IXEpPesgsWAWCG1sw+C605d9mnCx7TYnTY8y+6+2It4Yhl8Rby4lfrq7
         gMiyo3XV+cCgUjo6AeRyrSOgnop4TBxvaHsPL2+2F+rdT28YSmUj4M5yKJnPnELwo1Vj
         1PPorv5aGRpCS2LqMGlzYlRrIysFqizfxAuuUgxjSBV2GTMO3D3gKFck3CwNrUyHPkVm
         9vcrAquem+DctcD6HSuRKkA+MN8XsGGeUpp74yutH0hOUfNSHk+gP7ZSXl1Slk5VJLzO
         z9KnfjovJY3HtBHU/eMhGMo036e+1uz0iYkb/rTux5iYUsuivknRVBpLtXbI1Ko4KCOn
         vqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742913180; x=1743517980;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OKRABh44uDFI70lZVbe1fR/gjcdCuWiPeTV+hZF44Lg=;
        b=oXAn3Y3j9ULcftn4Pi0GoK1Z/fZBorbvNH6+5nkaZjPg1xLRFHF7YUSFyxQpAoHUbY
         Tlof8fImr0x8mtzMf7tCL2K6yegndPdxes9ZTNX8wrJyJYqbH0VULmWDwjP5da7TYq2n
         Ch3kJmtqT4pqUXV6pFT6MfyY8MIo5yF0J4wqSg+XD+Sc4pJAJi/xZOXxQ4KtSzBYHCfH
         DRh+/bQku2V1Iq9SBaxyhWhkzLMSQeR915RZuXXs4vAc733tkSBsHdjITKp1E1ozXHFM
         X+V5/FnKc5XPLmZBR19GUPf8igsrCtUIr/R9pkbN8ItS4JffidCrIpJVspWFNUwPJXVY
         FhPw==
X-Forwarded-Encrypted: i=1; AJvYcCVRasSrNuFJH0796PeWuCWa4XfcygE8gi2J2yxpiE9VpUys0aI6Q+bRLBbyRzR4WMbRJPY1xJktk2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxht/Rve10BxKaZfprnkinNIRst2HQVZrUZTJTDQBhRM0Xz4LHM
	M4wXBbpLWn2QlQhMeNhbbVRwT5k1sH4k1LwAurKqIBkCxyxg7RWjqOg78B4UZQ==
X-Gm-Gg: ASbGnct5TQHIRqifnE9mIU3Jo7TZYkMYNoBSWroWn64pdGUuQxN+surWiYaxpo+K8zV
	lMvnDsucc1UuG1Ul8tH9xe31/Up104SX2dTyoUwTuDsZsW5Qif/3YKbP6BfLzNso+3EBWesATlN
	n44xiYSfDXGul+J1bHBIOSDk7BQWVA3MT0gixRPDcq7ViiGXQknRQ1xBleCgG3Lri9nEJOK6er6
	tqzfrXUK5lXZHtCY5+oXM5UY7bwGs/dag1i7P96lTT13ArIZPo9elO5FOiYPB0GCUhCQg8Y1EeX
	7oNX7BJnc3ek2lfBhvJlsnwKVDhrePljn5r66iDwDm3dUwxjprhKYcY9
X-Google-Smtp-Source: AGHT+IEB+XaCO6duAN2wp0HmjUzHuf7tiQOHA3Esz/U9fWrPnrUspdywgNu7CbKOFz9lwCKIl8JtAA==
X-Received: by 2002:a17:90b:5450:b0:301:6343:1626 with SMTP id 98e67ed59e1d1-3030fe58e5bmr25896303a91.1.1742913179728;
        Tue, 25 Mar 2025 07:32:59 -0700 (PDT)
Received: from thinkpad ([120.60.136.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf64aca3sm14431313a91.49.2025.03.25.07.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 07:32:59 -0700 (PDT)
Date: Tue, 25 Mar 2025 20:02:54 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, 
	broonie@kernel.org, bbrezillon@kernel.org, linux-mtd@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 1/4] mtd: rawnand: qcom: Pass 18 bit offset from QPIC
 base address to BAM
Message-ID: <bu2msy7ngxzjk54rdq3fmgvww5rrn5ogjm4uq2vt2pwp6toxfw@ytvk6x6wcgi5>
References: <20250310120906.1577292-1-quic_mdalam@quicinc.com>
 <20250310120906.1577292-2-quic_mdalam@quicinc.com>
 <20250318073332.guylcyqjmfq5nyyr@thinkpad>
 <004c7c4a-69b4-c6f6-14c2-eb62672a7125@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <004c7c4a-69b4-c6f6-14c2-eb62672a7125@quicinc.com>

On Thu, Mar 20, 2025 at 11:23:40AM +0530, Md Sadre Alam wrote:
> 
> 
> On 3/18/2025 1:03 PM, Manivannan Sadhasivam wrote:
> > On Mon, Mar 10, 2025 at 05:39:03PM +0530, Md Sadre Alam wrote:
> > > Currently we are configuring lower 24 bits of address in descriptor
> > > whereas QPIC design expects 18 bit register offset from QPIC base
> > > address to be configured in cmd descriptors. This is leading to a
> > > different address actually being used in HW, leading to wrong value
> > > read.
> > > 
> > > the actual issue is that the NANDc base address is different from the
> > > QPIC base address. But the driver doesn't take it into account and just
> > > used the QPIC base as the NANDc base. This used to work as the NANDc IP
> > > only considers the lower 18 bits of the address passed by the driver to
> > > derive the register offset. Since the base address of QPIC used to contain
> > > all 0 for lower 18 bits (like 0x07980000), the driver ended up passing the
> > 
> > What is this address? Is it coming from DT?
> > 
> > > actual register offset in it and NANDc worked properly. But on newer SoCs
> > > like SDX75, the QPIC base address doesn't contain all 0 for lower 18 bits
> > > (like 0x01C98000). So NANDc sees wrong offset as per the current logic
> > > 
> > > The address should be passed to BAM 0x30000 + offset. In older targets
> > 
> > You gave no explanation on how this 0x30000 offset came into picture. I gave the
> > reasoning in v2:
> > 
> > "SDX55's NANDc base is 0x01b30000 and it has bits 17 and 18 set corresponding to
> > 0x30000. So it is correct that the IP only considers lower 18 bits and it used
> > to work as the driver ended up passing 0x3000 + register offset."
> > 
> > Then you replied:
> > 
> > "This address 0x30000 is the address from QPIC_BASE to QPIC_EBI2NAND
> > e.g for SDX55 and SDX65 the QPIC_BASE is 0x01B00000. So here lower 18-bits
> > are zero only."
> > 
> > No one outside Qcom knows what QPIC_BASE and QPIC_EBI2NAND are. We just know the
> > NANDc address mentioned in DT, which corresponds to 0x01b30000 for SDX55.
> > 
> > Please reword the commit message to present the full picture and not half baked
> > info. This is v3, I see no improvement in the commit message, sorry.
> > 
> > > the lower 18-bits are zero so that correct address being paased. But
> > > in newer targets the lower 18-bits are non-zero in QPIC base so that
> > > 0x300000 + offset giving the wrong value.
> > > 
> > > SDX75 : QPIC_QPIC | 0x01C98000 (Lower 18 bits are non zero)
> > > SDX55 : QPIC_QPIC | 0x1B00000 (Lower 18 bits are zero) Same for
> > 
> > There is no address as '0x1B00000' in DT.
> 
> Mani,
> 
> Please see if this commit message would be acceptable?
> 
> 	The BAM command descriptor provides only 18 bits to specify
> 	the NAND register offset. Additionally, in the BAM command
> 	descriptor, the NAND register offset is supposed to be
> 	specified as "(NANDc offset - BAM base offset) + reg_off".

Isn't it, (NANDc base - BAM base)? 'offset' is not valid here.

And also, you are just mixing the names everywhere. Here you say, NANDc base
and BAM base, but in patch 4:

"NAND register addresses to be computed based on the NAND register offset from
QPIC base". So the second address is BAM or QPIC?

Please be consistent with naming.

> 	Since, the nand driver isn't aware of the BAM base offset,
> 	have the value of "NANDc offset - BAM base offset" in a new
> 	field 'nandc_offset' in the NAND properties structure and use
> 	it while preparing the descriptor.
> 

And what about 'nandc_offset'? NANDc is already the term used for NAND
controller which has the base address of 0x01b30000 in DT. So clearly, the name
of the offset variable is not correct.

> 	Previously, the NAND driver was incorrectly specifying the
> 	NAND register offset directly in the BAM descriptor.
> 

No. Previously, the driver was specifying the NANDc base address in the BAM
descriptor. You are now trying to pass the register offset.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

