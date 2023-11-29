Return-Path: <linux-spi+bounces-84-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0357FD0B5
	for <lists+linux-spi@lfdr.de>; Wed, 29 Nov 2023 09:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F021F1C2092F
	for <lists+linux-spi@lfdr.de>; Wed, 29 Nov 2023 08:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79938125AF;
	Wed, 29 Nov 2023 08:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="P3LJ36Ug"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CB083;
	Wed, 29 Nov 2023 00:28:33 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 929098F6;
	Wed, 29 Nov 2023 09:28:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1701246511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wMoiMytgcumkKFLAJMoH9xk3ngRLwqpyXtXaQaRIiJo=;
	b=P3LJ36UgS3LTJz586QgMxNz+q8Zz5Jpc8V5Of21zhc66kfZa5NxxMfdJ4nip+EmgEISHRm
	DhaYhLa/U1u/oodhbGxToYg3iySiW9OGaoG1X/w40DD/3JXupBPJNsKpC8ggAp26ZzHPDC
	73FlP8zIjaYPkBgyybzBvUMUjc7hUSGgG7VduDW6RSvYok6ewKiTFX44NUxBeelxFdbk/F
	G/e4Aji9+6gx/bDN+l/36LDWDHnds2WBc07PIhBa4vX3el/fa/OGzrUmlrkljpjNrHztPF
	gxrxrAOp3XG6jV0AyrdkE+PwPVuSeA3aE/esK7cpRhQTUfsJeiWNzr+R+MuxXg==
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 29 Nov 2023 09:28:31 +0100
From: Michael Walle <michael@walle.cc>
To: AceLan Kao <acelan.kao@canonical.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav
 <pratyush@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard
 Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Mika
 Westerberg <mika.westerberg@linux.intel.com>, Dhruva Gole <d-gole@ti.com>,
 linux-mtd@lists.infradead.org, Mark Brown <broonie@kernel.org>, Kamal Dasu
 <kamal.dasu@broadcom.com>, =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?=
 <j.neuschaefer@gmx.net>, Mario Kicherer <dev@kicherer.org>, Chuanhong Guo
 <gch981213@gmail.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/2] spi: Unify error codes by replacing -ENOTSUPP with
 -EOPNOTSUPP
In-Reply-To: <20231129064311.272422-1-acelan.kao@canonical.com>
References: <20231129064311.272422-1-acelan.kao@canonical.com>
Message-ID: <60dec3dd502baab260da06fe01453c5d@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

> From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
> 
> This commit updates the SPI subsystem, particularly affecting "SPI MEM"
> drivers and core parts, by replacing the -ENOTSUPP error code with
> -EOPNOTSUPP.
> 
> The key motivations for this change are as follows:
> 1. The spi-nor driver currently uses EOPNOTSUPP, whereas calls to 
> spi-mem
> might return ENOTSUPP. This update aims to unify the error reporting
> within the SPI subsystem for clarity and consistency.
> 
> 2. The use of ENOTSUPP has been flagged by checkpatch as inappropriate,
> mainly being reserved for NFS-related errors. To align with kernel 
> coding
> standards and recommendations, this change is being made.
> 
> 3. By using EOPNOTSUPP, we provide more specific context to the error,
> indicating that a particular operation is not supported. This helps
> differentiate from the more generic ENOTSUPP error, allowing drivers to
> better handle and respond to different error scenarios.
> 
> Risks and Considerations:
> While this change is primarily intended as a code cleanup and error 
> code
> unification, there is a minor risk of breaking user-space applications
> that rely on specific return codes for unsupported operations. However,
> this risk is considered low, as such use-cases are unlikely to be 
> common
> or critical. Nevertheless, developers and users should be aware of this
> change, especially if they have scripts or tools that specifically 
> handle
> SPI error codes.
> 
> This commit does not introduce any functional changes to the SPI 
> subsystem
> or the affected drivers.
> 
> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>

Acked-by: Michael Walle <michael@walle.cc>

-michael

