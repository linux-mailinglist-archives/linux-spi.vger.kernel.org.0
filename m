Return-Path: <linux-spi+bounces-9697-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4A9B39984
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 12:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239753B7EA5
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 10:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262E13081CF;
	Thu, 28 Aug 2025 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Voa9vrjz"
X-Original-To: linux-spi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902482701D1
	for <linux-spi@vger.kernel.org>; Thu, 28 Aug 2025 10:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376402; cv=none; b=NfX/LESPFQB6tN4DkLvbe75zTji0lIaUVD5zUMlnB6dYMgr8/2Wasp7dlnf2csiO6xY+kheOLlqoxpw0sdE245Jys9cB5CXb/zhWnzshoofZduKcjhLnVRoMYOG+lvXlPo3C27/GFGMe1wYkzLkgkhXPGKaYXM4fkLAyH9Q87cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376402; c=relaxed/simple;
	bh=C1DYH4kVeKuTMIZnOmx1ZxMHuw47TEaonNH+ssfuphc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=o9HjqqaA8wiNIdyUDAqqRAI36EKch2iVidfXsatc1PxsbojWeMc6CCQlM+Wt5pI5Y0T1YJsmTMFscB6vzWz71sOXJsLkKPHBR1b6H935HdJ+5ZTIo5A6tg89U3jkLnFBoPL8EoysUcPTXNKZhhRhDbyvym4YQUV1YnYf4aft8uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Voa9vrjz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756376399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mBAEoFNbmswFsnSxAIv1w+pBcSdXwLgSTS2jwoutXlw=;
	b=Voa9vrjzTwnIk1XnGe0lK5O7Py9HAgFReyjhQI8T2ENUvOwdCMAYApkR2u8qqCHwm/Lrga
	V0b52jm5rnnRZkuWWLsCFA6eM2mfUE0n542QTNDJRVdnSv5eW3Qu9LuQGiWr9odywSypQE
	sBqvdrMI8uPMDsJs2fltZeeNteUCdEA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-hSOtvb2KMECPV4MqtEBcAg-1; Thu, 28 Aug 2025 06:19:57 -0400
X-MC-Unique: hSOtvb2KMECPV4MqtEBcAg-1
X-Mimecast-MFC-AGG-ID: hSOtvb2KMECPV4MqtEBcAg_1756376397
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a1b0c5377so3674415e9.3
        for <linux-spi@vger.kernel.org>; Thu, 28 Aug 2025 03:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376396; x=1756981196;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mBAEoFNbmswFsnSxAIv1w+pBcSdXwLgSTS2jwoutXlw=;
        b=lJySokFTKAJ6tpDEssRs2PBWqQagiivwAd842+XEsmoe2UuGeKvcniwwNyuM5yuNzc
         /mgiCz6s6MYe7sSS35Pj04voSLBYNKBvTEnorVDg7mPpOHYCMqy3QF8G1QjqLwyewLGg
         sxokgNV85fSOmVRXtGJPhoEJLqcVKcesuNnITxxsXS1f2VobdlLWTibtnvFNonOeZLqR
         kzAWhDvVr6cktdYcQ4GzrGN3aiJ3AJheIekuOBaLpCLnRMQgJOAQj7sbe1WwUsbacLjP
         ieqSGVAMYoaVm1ITQHkWfm1H+XCtHXqt7wHt1dn9KQPjy/wAGhWW3Ex8r3TnPZ4bDCt2
         YhWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo66vE2yzPm82mODF2qHcJWoLpTNZLTebedVOVtqjRU7MHYtfIbaom7tIrKrrvloazov7JRKi33ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEje1TSgt8K0spXGTNy2v4dxr2IbTJqA5SBjiDn7rkmSNaUIMu
	gzscMI8usRpSwrxQWjiVSScP8H+VEYEBko3KTM2lvolYtiqDrOuepPOpQZcA/Jec/z+/7L4lXcQ
	ecS4EAzlGP0HSad/dtcRsP9Nz9b8ggO0hgWM1S5MhpY8KwFLjm3tHj+V0DC5lqA==
X-Gm-Gg: ASbGncvV4l/XCygiI32cg2OdF7d9cOzaWUrgKk/Sz2FEZr6jXpHlvRQ5U8bntSYt7/Q
	vQ/xryV0F52Ygr6KkfFMMpPvLXGvaiP3fPFc5JKkzIUVK4dO3gpHEIdgew9Vhfi0eFy+hH/O/bO
	m9V7AKHyEX4Vunwetxl6Dc7O15OYS52Ckwtm5cKhJYgq14GZe1RtzFw9P2C8KVnQ6IvTPtdQTRC
	cMo2r1/MWsG2AHc5IssxDkTja4Idkq8jeJmVqt5z3KK8I1EpjvUdwal34HSN0mpdREVrq1tqoc7
	n4wP0svkCVavO44fP6iD72+zjTknLgRN
X-Received: by 2002:a05:600c:a47:b0:456:1824:4808 with SMTP id 5b1f17b1804b1-45b517cfe66mr169732975e9.32.1756376396486;
        Thu, 28 Aug 2025 03:19:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRzvWTBo2GxDcNnrIlhFHzO2y1QKjqd6ebF9+adqAAZUSWw06wXWnWxmDIghxndloNXqg0Zg==
X-Received: by 2002:a05:600c:a47:b0:456:1824:4808 with SMTP id 5b1f17b1804b1-45b517cfe66mr169732795e9.32.1756376396123;
        Thu, 28 Aug 2025 03:19:56 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b79799c33sm26094735e9.5.2025.08.28.03.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 03:19:55 -0700 (PDT)
Date: Thu, 28 Aug 2025 06:19:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: andriy.shevchenko@intel.com, harald.mommer@oss.qualcomm.com,
	quic_msavaliy@quicinc.com, broonie@kernel.org,
	virtio-dev@lists.linux.dev, viresh.kumar@linaro.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	hdanton@sina.com, qiang4.zhang@linux.intel.com,
	alex.bennee@linaro.org, quic_ztu@quicinc.com
Subject: Re: [PATCH v4 2/3] virtio-spi: Add virtio-spi.h
Message-ID: <20250828061943-mutt-send-email-mst@kernel.org>
References: <20250820084944.84505-1-quic_haixcui@quicinc.com>
 <20250820084944.84505-3-quic_haixcui@quicinc.com>
 <20250821044231-mutt-send-email-mst@kernel.org>
 <42806aa8-8cf1-476e-b775-50859fe0e7f1@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <42806aa8-8cf1-476e-b775-50859fe0e7f1@quicinc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 70JC4XT-mPnBlKyiCF9mThYrcuZGDg2Lu6tiie7ufc4_1756376397
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Aug 25, 2025 at 05:12:44PM +0800, Haixu Cui wrote:
> 
> On 8/21/2025 4:42 PM, Michael S. Tsirkin wrote:
> > On Wed, Aug 20, 2025 at 04:49:43PM +0800, Haixu Cui wrote:
> > > Add virtio-spi.h header for virtio SPI.
> > > 
> > > Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
> > > ---
> > >   MAINTAINERS                     |   5 +
> > >   include/uapi/linux/virtio_spi.h | 185 ++++++++++++++++++++++++++++++++
> > >   2 files changed, 190 insertions(+)
> > >   create mode 100644 include/uapi/linux/virtio_spi.h
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index daf520a13bdf..3e289677ca18 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -26760,6 +26760,11 @@ S:	Maintained
> > >   F:	include/uapi/linux/virtio_snd.h
> > >   F:	sound/virtio/*
> > > +VIRTIO SPI DRIVER
> > > +M:	Haixu Cui <quic_haixcui@quicinc.com>
> > > +S:	Maintained
> > > +F:	include/uapi/linux/virtio_spi.h
> > > +
> > 
> > I would add a mailing list:
> > 
> > virtualization@lists.linux-foundation.org
> > 
> > 
> 
> Hi Michael,
> 
> Thank you for the suggestion to add a mailing list to the MAINTAINERS entry.
> 
> I noticed that other VIRTIO drivers, such as VIRTIO BALLOON, are currently
> using virtualization@lists.linux.dev rather than
> virtualization@lists.linux-foundation.org.
> 
> Just to confirm—should I use virtualization@lists.linux.dev for consistency,
> or is virtualization@lists.linux-foundation.org the updated preferred list?
> 
> Appreciate your guidance!
> 
> Best regards,
> Haixu Cui


virtualization@lists.linux.dev

Same as others.


