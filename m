Return-Path: <linux-spi+bounces-9257-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFEDB180CA
	for <lists+linux-spi@lfdr.de>; Fri,  1 Aug 2025 13:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4558F1C82047
	for <lists+linux-spi@lfdr.de>; Fri,  1 Aug 2025 11:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8B3242D74;
	Fri,  1 Aug 2025 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FRoHrdfc"
X-Original-To: linux-spi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10FA239E69
	for <linux-spi@vger.kernel.org>; Fri,  1 Aug 2025 11:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754047048; cv=none; b=Qrq8tp00Pg9TES5eUlomXRWlLirr8nvRRG1yJxhNKigPKh0K9OGhb0m5amHvNsmJLcqGcVdqszLy+Q9aMkWOk2b9bvaGrZ0XsYWmk/2NOHh5nIDhV76xGREosqtuEstz2kYyADclUU3LrquxGZGPXpHEtncynUVF5W1JbUHt8Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754047048; c=relaxed/simple;
	bh=8JQsiVWTM3ruJ2jFKdGrmV8VbBNegx7F5yFOdazGfKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MaAQqQn3hDb2eQ85dYwQLH4SBVkpDvEosXu/CDCk2FoG/SM+xR+pckvVjacba2fvZm8+K/v1tcEeEMhtXX6tt0JNW2L8Qq+xic5ASvy+Tfwt7A8aFsQYmdAhXyGD00AdRkFuCVSXUX4v4DLq22x+jqW8sdRmA2yWbM6NYmVUjTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FRoHrdfc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754047045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TkK4LWOcguxSSKDlgoUZDb5ZXpOEItT6YyrOmMD6H70=;
	b=FRoHrdfcEA1FqVFAXNN3m/QWbwFp86ghttYaJYIWWQcWX5vcqIY/Ai3TDCOmRRkTuCKNA1
	c2DQmDQLH60j8nx8ahwLEuhjXsOJS0qU09+emqyp4X1+LUHSGj01wYXMhmoVnqOBxG8jIN
	hw3FWR0SE23knF+rBe0fM1N4LVp3Zrk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-Dfo5LgvDPfKPJDVYzXvpxA-1; Fri,
 01 Aug 2025 07:17:22 -0400
X-MC-Unique: Dfo5LgvDPfKPJDVYzXvpxA-1
X-Mimecast-MFC-AGG-ID: Dfo5LgvDPfKPJDVYzXvpxA_1754047040
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F7B21800350;
	Fri,  1 Aug 2025 11:17:20 +0000 (UTC)
Received: from [10.44.32.226] (unknown [10.44.32.226])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1732C1955E89;
	Fri,  1 Aug 2025 11:17:16 +0000 (UTC)
Message-ID: <9af427df-ad31-46c8-8796-3d7ab55ee9d1@redhat.com>
Date: Fri, 1 Aug 2025 13:17:15 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dpll: Make ZL3073X invisible
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>,
 Conor Dooley <conor.dooley@microchip.com>
Cc: netdev@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <97804163aeb262f0e0706d00c29d9bb751844454.1753874405.git.geert+renesas@glider.be>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <97804163aeb262f0e0706d00c29d9bb751844454.1753874405.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 30. 07. 25 1:23 odp., Geert Uytterhoeven wrote:
> Currently, the user is always asked about the Microchip Azurite
> DPLL/PTP/SyncE core driver, even when I2C and SPI are disabled, and thus
> the driver cannot be used at all.
> 
> Fix this by making the Kconfig symbol for the core driver invisible
> (unless compile-testing), and selecting it by the bus glue sub-drivers.
> Drop the modular defaults, as drivers should not default to enabled.
> 
> Fixes: 2df8e64e01c10a4b ("dpll: Add basic Microchip ZL3073x support")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>   drivers/dpll/zl3073x/Kconfig | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Please use 'PATCH net'... otherwise:

Reviewed by: Ivan Vecera <ivecera@redhat.com>


