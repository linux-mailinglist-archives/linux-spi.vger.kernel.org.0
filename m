Return-Path: <linux-spi+bounces-9698-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5347B39A31
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 12:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958B93AEE19
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 10:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA92430C63C;
	Thu, 28 Aug 2025 10:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4NFaD8/"
X-Original-To: linux-spi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F07D30EF99
	for <linux-spi@vger.kernel.org>; Thu, 28 Aug 2025 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756377253; cv=none; b=BXfhP2eAPk/8hnq6moe6hJ6lwTB3KoUHYLzDMKZGer7gBkm4momo6+Zi97yQiqRJFx/bTy+so//tSrCzdV6UUUNef8GapHrUAkAUSdBgRhf7uMtAGgo7dL8Qghp/faYmLVVTclabToUXIeNKpcsIP5hPX4fwTvG/Ht5RELkUpeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756377253; c=relaxed/simple;
	bh=wtX1QaBz9wXYD4soHMyGal0DPdeF2TDx5Z3Sfo0JTI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Nl98n2ntIEwOqDAHPAnYfqNbokBHkrP+bDVO66oEE2GUqzkmf3CJMiLrlt9jWos+GGCL4JWySXYxX/bncrZ+jPXrvwuVHNTySyHPhdH/jamivp71TSh0mVZ+LUcB69H/tKpaKD6eMgSVXcqGBwdihusOSZQ6+xj74Xg4+NvPWlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T4NFaD8/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756377251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+FTwNA1bk0v6rrtoNJE35RPWClvjcf2jCc0VyKhrWjA=;
	b=T4NFaD8/00H9VwOmVA39JJI18EBp0PIl49guU0/+wmj6OwT23Qfc1e06aYLNDqCdwnblTI
	V9zXnXvisIzBzwqkLT0bH04gIuI5p1h+cdvhOscrSPrzOpdb1GIPrAlVJepGS5QuwsaZAB
	U8Tz7w44OrdFTN9Mrg2MuMxe6iJH2QM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-Jg4GzpQVOjKl8SBSWnH3jQ-1; Thu, 28 Aug 2025 06:34:09 -0400
X-MC-Unique: Jg4GzpQVOjKl8SBSWnH3jQ-1
X-Mimecast-MFC-AGG-ID: Jg4GzpQVOjKl8SBSWnH3jQ_1756377249
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3c6abcfd218so587647f8f.3
        for <linux-spi@vger.kernel.org>; Thu, 28 Aug 2025 03:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756377248; x=1756982048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FTwNA1bk0v6rrtoNJE35RPWClvjcf2jCc0VyKhrWjA=;
        b=BwaUQYejUGZ4lNYvXkhG+Y4B+yE2ADLb3D+YgJfMvIXuOejrpry87c9gvsHOXJhTll
         0y1vNV5bte4JGHz1IxvasUVWXCyLDeF0I0rpeF8xexVKPQTgFDepAnf7SqeSuwVpO0dP
         nOhQo1S1EIb35n2c2v4/uheRP/7oJzomzNG9N/N6rY+2q0pu1XvLr4FB9l3g/0V5yqRU
         xlWXL/6rymL5gte4PFDS5HH60K8vQiOgmcmEgk7u/dc9+blL8xKFn+vnfjjNR8kVhhhv
         2VO3ChQmB4iv7AykBZAvltp+z6Wm3Idsa5gV9VEd76zq34LxDTTadjNw6fGYUZ+iaI+J
         PWNA==
X-Forwarded-Encrypted: i=1; AJvYcCWgsd0iOHBn0h2ZaLBVGhDwfeSYDjWUsX7aOiQr341wjm4L/xGMuhtwRQj8AZmCkZduivIinFskHTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGoi+G6htZJG590p661rW2w/HbyKA2SQpXldHVLzrZla+egwTU
	ePiHof3k98DfNjLkFX+p9+Ph5Jg2Eb3SHHgZd3/bkEpNUpRgX7US+IFuGyjFcK8Qt4eefin7JkI
	gRiHKxKxtUgajH+UtKVPPaYxpGhytXkUVRS7OLTXpnb+R+Fz1s5sdELETffb9ng==
X-Gm-Gg: ASbGncsuJSxFK6iq3WBAOs8aJF4pLmeGzKpHS6uTxWDzRg4gYmOHHavTK1GPqUksYnr
	b/SCx55FumOVZGumKUQ+8cHUQ5fKJbLOS6CvzxQfEdWSoZjTm+PuC9LOBVyrbeGQcutjPAQmVCU
	MOAuVJYwrZF7k6vV+oAuzuy9a/u4YpDwB4SBV9FUS+agI4exXBA5swPPEI3JAtpL5Mt/2PU5gYR
	AwoTzLXz/a/V0HYdBwHp4WhIVVJknOxBxGDlqHDXWzwvyRgnA4LQ32cjVF0krHz8jO6kvlUwUDd
	/ZCMOJrHS1eyqX/fATX8bOA8lMegDUoh
X-Received: by 2002:a5d:5f8e:0:b0:3c8:443:4066 with SMTP id ffacd0b85a97d-3c804434575mr12697628f8f.61.1756377248606;
        Thu, 28 Aug 2025 03:34:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8oxOyBv4dBursJjsEHiDAvHkrowxoRe1iT8xj3dArCwD5U9uf5ibj+41tEIuHcsKWsgLqeg==
X-Received: by 2002:a5d:5f8e:0:b0:3c8:443:4066 with SMTP id ffacd0b85a97d-3c804434575mr12697598f8f.61.1756377248066;
        Thu, 28 Aug 2025 03:34:08 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711211e87sm23884597f8f.44.2025.08.28.03.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 03:34:07 -0700 (PDT)
Date: Thu, 28 Aug 2025 06:34:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: andriy.shevchenko@intel.com, harald.mommer@oss.qualcomm.com,
	quic_msavaliy@quicinc.com, broonie@kernel.org,
	virtio-dev@lists.linux.dev, viresh.kumar@linaro.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	hdanton@sina.com, qiang4.zhang@linux.intel.com,
	alex.bennee@linaro.org, quic_ztu@quicinc.com
Subject: Re: [PATCH v4 2/3] virtio-spi: Add virtio-spi.h
Message-ID: <20250828063350-mutt-send-email-mst@kernel.org>
References: <20250820084944.84505-1-quic_haixcui@quicinc.com>
 <20250820084944.84505-3-quic_haixcui@quicinc.com>
 <20250821044351-mutt-send-email-mst@kernel.org>
 <1a63f5f9-add0-4a22-b01c-2f0c8d9efcec@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1a63f5f9-add0-4a22-b01c-2f0c8d9efcec@quicinc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gYlS1lNJRynaQwqFL975dktFVc9jQrt38tmSm-Uem_w_1756377249
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 25, 2025 at 05:19:03PM +0800, Haixu Cui wrote:
> 
> 
> On 8/21/2025 4:45 PM, Michael S. Tsirkin wrote:
> 
> 
> > > +
> > > +/* Sample data on trailing clock edge */
> > > +#define VIRTIO_SPI_CPHA			_BITUL(0)
> > > +/* Clock is high when IDLE */
> > > +#define VIRTIO_SPI_CPOL			_BITUL(1)
> > > +/* Chip Select is active high */
> > > +#define VIRTIO_SPI_CS_HIGH			_BITUL(2)
> > > +/* Transmit LSB first */
> > > +#define VIRTIO_SPI_MODE_LSB_FIRST		_BITUL(3)
> > > +/* Loopback mode */
> > > +#define VIRTIO_SPI_MODE_LOOP			_BITUL(4)
> > 
> > It is generally preferable to have an enum with just bit
> > numbers.
> > 
> > 
> > E.g.
> > 
> > enum {
> > VIRTIO_SPI_F_CPHA = 0,
> > }
> > 
> > 
> > Userspace can add _BITUL wrappers itself if it
> > wants.
> > 
> > 
> 
> Hi Michael,
> 
> Thank you for the suggestion regarding the bit definitions.
> 
> Would it be acceptable to keep the current macro definitions with _BITUL()
> because these macros are also used within the virtio SPI driver itself?
> 
> Looking forward to your guidance.
> 
> Best regards,
> Haixu Cui
> 


move them to the .c file if you want them.


