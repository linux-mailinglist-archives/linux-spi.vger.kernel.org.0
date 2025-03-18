Return-Path: <linux-spi+bounces-7191-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DE8A67174
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 11:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69C2319A251D
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 10:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DC8208966;
	Tue, 18 Mar 2025 10:37:04 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70998207649;
	Tue, 18 Mar 2025 10:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294223; cv=none; b=DO0QSJXQRAcgRufhfcDU7h8VkpEqtYtihiVrmIQyXzMOHnJzXp78gthW9ZwJOM3yioGqM1VcSW2gTlZsQ9A5gw3p7li8PwxMPrOh6tf2oEgBwg9pun8sxPvcKcVuEJLEaJVXWX/UoyA2DJnHEuC2P0sAsyLkV74/Gs79gNNf8aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294223; c=relaxed/simple;
	bh=JMxrN0pDr4x+nO50gL69TEnVbLQC/DBVB/ZbdiLbS3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/W9fRnhV987+yWAtx/D0vzuQJ7bTIIHTivKYLBbBQJDeWBj4lmDAcpCsBBdg3Vc1TwGuRLQ9OBh3UP5gw8VRs/RQWf2/PU1SXjLq8aspgXLhFT3baL2WC6vpPiMCdu78hG2eZKTuUA6TM1sPdCSn5jw/zU1zszYqskLoC28Fyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac297cbe017so1197676666b.0;
        Tue, 18 Mar 2025 03:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742294220; x=1742899020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvARDVtB7JkqVXNjKMDBYbGz9OQ7SfkO/xoQmTkCOTo=;
        b=Bey8IyKxpG7SZh2lsHgn0DwCbIR/pvI1voNW2lbIMCVOLU4F5i/FrYLxTr31Dna8k9
         H98OE7jXPSV2Vh7DSUOFhsEqLgeWMtiNK5roDwu7PO4HS7VrpYfpOpSRGcNB4SK6Y0Gn
         258DsCC39BzoYX3Zh/o67FdHAGWaMjFGiE3MO225yQgHvZc/1DMG0Ztv0ENGjpg4y/Cw
         UvoNbnzEjfTACSczhcuoXb7EHwNu2xoHzBD2eNlHOqmuF0rn4f9aUftldC4Nkm+WMOv3
         gNQtIE2ryJKdHzF3Q0HJGk9cgvKm2Sx+J+cPI7ZbS2YeYrjfzUbIBVmiHduXgm/s9jUq
         VflA==
X-Forwarded-Encrypted: i=1; AJvYcCUEiB1LZm9392gtDnozYbQhyxUYBHw9Wt0+otWbcyCI1IXspiqPFPEtwLy9ZTa1AT75Ew1wlZkswmj+7hk=@vger.kernel.org, AJvYcCUmRaGyDXpa3AOsMxFSpiQe2ZDAa0GfYPbF+ZkVzSYj5TPtZ6KtCYdxLRefJhB6CsGXzzy3bKMtLY/F02c=@vger.kernel.org, AJvYcCX7G1vnHvpugfPdzTqg+h3Left99wfYjQPgECj4xXYA5E+sv7aoVnZY8OME9MF78MIZFzJbwnxpxOcG@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3A1LfC0npjW/l6PFOH7qxgo21QGJ5LT3BD08J0bD3ULXNdMTU
	BNa87wLWSRPZFLmANN5ZhC9ojBRbYBxTqjBSQu+DUBEVNfclaxfE
X-Gm-Gg: ASbGnctTbPN3ng2E73CepYpnMoZNJtuQW56mPR873yCGUHcnoElGXC2vEWa7/YkYDuP
	R50hLXvxwFTNkkJ5k5eDfOzZIXRH+ahJjDygKKLrdA3fQvJS6GFl8PAxF8ZAlpqfWGPI3L3ThYU
	Sjxjij0gB8MDKIfeMsAuPAudCjPh4hiDrVkwCW4+JV2Gkx8ay5yFtZFlgEIGEsJJ8s5XlRIzOBZ
	avBw57G8PcSzMP4CYNOND+2JkWOLifeL7e6fmLZ8pVrSuS8nQNV4Ow3+9zUCWLGBJLEk58WieNo
	hdcIxe+zdrnevn+sWRjRiYKg4BxTwJpyIoFx5BSYb3CD0g==
X-Google-Smtp-Source: AGHT+IGPt11q8QB4azGUuNMBE8ZgFA5896ls8k8MQn7yZ20EUxm8BA6qm5vygKlOnCUPsdIBIJtIew==
X-Received: by 2002:a17:907:60d4:b0:ac2:9a4:700b with SMTP id a640c23a62f3a-ac38f7d129fmr241470866b.16.1742294219359;
        Tue, 18 Mar 2025 03:36:59 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aecbasm813680766b.37.2025.03.18.03.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 03:36:58 -0700 (PDT)
Date: Tue, 18 Mar 2025 03:36:54 -0700
From: Breno Leitao <leitao@debian.org>
To: Mark Brown <broonie@debian.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>, linux-tegra@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	rmikey@meta.com, kernel-team@meta.com
Subject: Re: [PATCH 1/3] spi: tegra210-quad: use device_reset_optional()
 instead of device_reset()
Message-ID: <20250318-cuddly-translucent-teal-e2ac2d@leitao>
References: <20250317-tegra-v1-0-78474efc0386@debian.org>
 <20250317-tegra-v1-1-78474efc0386@debian.org>
 <22ffa8f5-6590-4602-853d-ceffed580f22@sirena.org.uk>
 <20250317-solemn-debonair-sambar-f04fa7@leitao>
 <f3e47d12-f6be-4bb5-b87b-84aa0037e1ef@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3e47d12-f6be-4bb5-b87b-84aa0037e1ef@sirena.org.uk>

Hello Mark,

On Mon, Mar 17, 2025 at 05:24:24PM +0000, Mark Brown wrote:
> > > There's no specific handling for ACPI here.
>
> > Do you mean no _RST method as stated above?
>
> That's only happening in the case where the device has an ACPI handle,
> the SPI driver has no idea why the reset API failed to look up a reset
> controller.  Your change is to the SPI driver, not the reset framework.
>
> > > It's also not clear that this is a false positive, the
> > > driver did indeed fail to reset the device and especially for the error
> > > handling case that seems like relevant information.
>
> > If the driver failed to reset the device, then device_reset_optional()
> > it will return an error code, but it will not return an error code if
> > the RST method is not found, right?
>
> > Sorry, if I am mis-understading the code here.
>
> Clearly if no reset controller is available then the driver will have
> been unable to reset the hardware.  That seems like something it
> actually wanted to do, especially in the error handling case - it's a
> lot less likely that we'll recover things without the reset happening.
> During probe it's possibly not so urgent but at other times it seems
> more relevant.

Thanks for your answer! Let me backup and explain how I am understanding
this issue, and my possible wrong assumptions:

  1) The SPI controller is reseted in the driver in a few cases:
  	a) At probe time
  	b) At transmission side (when there is a timeout to the controller)

  2) On the machines I have, I understand that  the controller failed to
     reset on both cases:
  	a) At boot time with "tegra-qspi NVDA1513:00: device reset failed"
  	b) At error handling with, the message below:

  	   tegra-qspi NVDA1513:00: QSPI Transfer failed with timeout: 0
             spi_master spi0: failed to transfer one message from queue
             spi_master spi0: noqueue transfer failed
  	   WARNING: CPU: 1 PID: 1221 at drivers/spi/spi-tegra210-quad.c:1120 tegra_qspi_transfer_one_message+0x780/0x918 [spi_tegra210_quad]

  	   Full log at: https://paste.debian.net/1363773/

  	c) I don't see the "device reset failed" in this case
  	transmission side. But the device doesn't recover also.

  3) These device fail to reset at probe because there is no ACPI method
     related resetting then (aka "_RST" methods), thus, device_reset() will
     return -ENOENT;

  4) Not being able to reset the driver seems to be the root cause of
     the WARNING flood I am seeing.


My assumptions, now:

  1) This controller doesn't have _RST ACPI method by design.

  2) It is OK to not have reset methods (!?)

  3) There are two helpers to reset the driver device_reset_optional() and
     device_reset().
  	a) For device_reset(), the helper will fail if the device
  	doesn't reset, thus, for ACPI systems, the _RST method needs
  	to exist and return successful, otherwise it will return
  	a ERRNO.

  	b) device_reset_optional() only fails if the reset fail (either
  	in ACPI or not), but, doesn't fail (aka returning 0) if reset
  	methods (aka _RST in ACPI) is not available.

  	c) Given assumption #1, device_reset_optional() is more
  	appropriate given that this method does not exist anyway.

  	d) This should be a no-op for systems that have proper reset
  	methods.

Thanks for helping me with this issue,
--breno

