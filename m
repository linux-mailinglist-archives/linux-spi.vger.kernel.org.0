Return-Path: <linux-spi+bounces-7188-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1142FA66C3C
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 08:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FA443BC736
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 07:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116A01E8356;
	Tue, 18 Mar 2025 07:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b7z9kbBL"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9370B7E1
	for <linux-spi@vger.kernel.org>; Tue, 18 Mar 2025 07:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742283707; cv=none; b=BWdxcH1Oi43K8ifdtvRlNHG18tIz6XguqZ0ALlrqNgJj1AiHFdMTsEZCjo22b+RCtbpentWpjjvBXtahuZEA8nEO/h3pDYHiFUothMRZmhinKWOe9BLFV/FblY0DPqahTxfTXlbETHB7Lout+beEk+DRrPDvL9u2CqPKQr87zkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742283707; c=relaxed/simple;
	bh=O9jZcWIWmMwWgw3SIuenwP/maVKbFbUsn3EZOj/MOjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pD6rlKMURkTvs8jHWv5lhYTJrXPZKOa+498vkg7adf0VLf+ucz7u1iaj/Wb2cl+AcsAAx1dGgMuLEEeGx/fHBjqroDYq4HFRqCFhtXCxuUHWf+J0ro6sh9aSYlbLIRL9eP+Z15LwBzlYyrsU6ywVL2y7JVCKNiOpFhkHMW/c1uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b7z9kbBL; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22349bb8605so112912595ad.0
        for <linux-spi@vger.kernel.org>; Tue, 18 Mar 2025 00:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742283705; x=1742888505; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lVZR04S+QbsB8ngo9JOY80Ix4bk7+hFvRXCVeHlbQmA=;
        b=b7z9kbBLUhVtZkdaLuc9mAF6k5D7oP3TalrtCa8yKSHdw2IFlgrzGJ8TK1zAz2V+Ux
         JoNhS6YOOmdF0KGH8kmkFj7UztnMKyEoPb79FczyvrQO2+/4HhD70rNEl4idwSt0CY66
         CfbhgOkZkpJx7OcVRtFkrGtysXbxXq3pqUSGYMDe0Nziio1R7O0IkOzcr3+kMYAYLjLD
         ZjaZ5wrTiSIKcpKumP3HuLBtiwKxzo8Q8uqLU7c2tKW+aPZkYLqaMHRQy98gHDu+K9Pf
         WIHY900okWqps3a0Y3U5rdMymcqwB4Vb0cf+XKJQk/MFN+G8tC58jnCx5Xg9KdmLoE9M
         kzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742283705; x=1742888505;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lVZR04S+QbsB8ngo9JOY80Ix4bk7+hFvRXCVeHlbQmA=;
        b=CzeSQLSVzE+HhUBtlkDiT/dLAi4RgESJYgQzUejRwhC0jArcvh8MMTrzIU/aBFM2pk
         3JOlXJXOFPyLNRjEgqyE02La3PsdL1kYdDZgTZQCwmeIz+chYLrl2+QV43y7TAWcdZvh
         QvQWWrCD4tLKM0uGsZiCmX2j2aqaHHX/D2mRnx+tXAkbbZAMOQUEbseY9FVxnW2/y6K0
         vZevsEb0eHzKrkkY0qtZG8nUGXHN/9SQqebiOwHb9oXaCQagsjAYmSzx+40uF3fO6qNp
         l+DCp6Xh1Zw35HPJzNtVV6UH5o2vE9rjRfxhPAaUqbynuCeZ5iq4LRvEr8+pLt4ChXCB
         gcXA==
X-Forwarded-Encrypted: i=1; AJvYcCVCKYFopbTV5+ASSBCwC0QIKlrTLAtLwt1qRpm+CpZ0vR/s+ztPknP+i5dXpPiHe2pnZCUiqaXAhtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YywzaEzFxboUgwPlkVf5dORYsFbDvCEqdcMifWlbvHFUaifDEZv
	+WUmy+jLFQfUM9aGEAWeVX/LL5Aj2uSEL4k2yjc5GeW79k3IyBPegRhnHTxtSg==
X-Gm-Gg: ASbGnctm6BiOdcTHafXZEe44GGWDZnwlAvMp0z/w8TG+oZPNdg6PlimvaLf3RJpviJA
	k9EQ+qz2Gb3ZYKHOGzf1J5CzIEHPXQISYRI7ukAEH6fIA9tNwtjNs3jEpwE/EUp74CTDID/M4lH
	KiX6Wn5/7BCH5CxvRJW5hYeJTXdPcAUI0cY6Z9ZAKmJlh7bs843fqQmealOpBYO4Er2q+cLvCbY
	/41hwLFDrwCWz32DecNT/KYiCTwtAug1WFIBBogvGYsFcWQYIjxUbQGMehmclkCebcmvEeKZhRP
	YtYs47FR/EXF+Kpqj9KR73cnvGj1wX48iqlE9VJJLf4ck0bgyCQTNIRx
X-Google-Smtp-Source: AGHT+IFyXEOBiMlUSN5i5N/Hw/HWhnWZVCQ3Gx+hf6RlAak5McTqA6i5CzSdroh1zfVKpZgEjUe7mA==
X-Received: by 2002:a05:6a00:4f82:b0:736:3c2f:acdd with SMTP id d2e1a72fcca58-737223b8ee6mr19051900b3a.14.1742283704908;
        Tue, 18 Mar 2025 00:41:44 -0700 (PDT)
Received: from thinkpad ([120.56.195.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73766322e03sm151481b3a.99.2025.03.18.00.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 00:41:44 -0700 (PDT)
Date: Tue, 18 Mar 2025 13:11:40 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	broonie@kernel.org, bbrezillon@kernel.org,
	linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 0/4] QPIC v2 fixes for SDX75
Message-ID: <20250318074140.yujrwgq743oqx5du@thinkpad>
References: <20250310120906.1577292-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310120906.1577292-1-quic_mdalam@quicinc.com>

On Mon, Mar 10, 2025 at 05:39:02PM +0530, Md Sadre Alam wrote:

Nothing in the cover letter to describe the series other than the changelog?

Btw, the driver has been broken for almost 9 releases and the fix series is
pending for 4 months. This tells a lot about the commitment to fix the bugs :/

- Mani

-- 
மணிவண்ணன் சதாசிவம்

