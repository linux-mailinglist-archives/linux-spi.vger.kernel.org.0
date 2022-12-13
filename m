Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3559364B782
	for <lists+linux-spi@lfdr.de>; Tue, 13 Dec 2022 15:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbiLMOhO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Dec 2022 09:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbiLMOhN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Dec 2022 09:37:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A38E21256
        for <linux-spi@vger.kernel.org>; Tue, 13 Dec 2022 06:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670942184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YeA7rNz9YtNXa30NSFNa5/BE9ikSCHuGqIiQHRpjT3Q=;
        b=IeCRaDARdSa2eQW9JHiLnZglsnTu2UcBHBseJIHsp8SIt0Zxph9lCRxEaXaLs8vSbJfGZj
        xLVsx5P3/GtxzsWL71TwPVHFFkduYbkYWGcfo0nggyQPDNgaP9q6rkHphevc/vrVAbD4Ed
        GxpEpmbT5umcurlMkMhGesBOr+ASV6c=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-70-8V4WWGaxM5KDZHt43RMcyQ-1; Tue, 13 Dec 2022 09:36:23 -0500
X-MC-Unique: 8V4WWGaxM5KDZHt43RMcyQ-1
Received: by mail-io1-f70.google.com with SMTP id b24-20020a056602219800b006e2bf9902cbso1979805iob.4
        for <linux-spi@vger.kernel.org>; Tue, 13 Dec 2022 06:36:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YeA7rNz9YtNXa30NSFNa5/BE9ikSCHuGqIiQHRpjT3Q=;
        b=jComY/2be4BrdLEZaexgv5l9UHcW2G0+opntlrf4H2i57WHpDpYprB8KdRGirenBkb
         LHOtdX3HzghTxK5L2aooUcKgcSd1QpGeegxfB3rhxym4RYe6uSdelJJON4fJ6Br/kbdq
         kRmMnmuomsHd8/2MzQ3KZKJjtfGWw5AyxpzczdZfAx6sPMFrOGAwZOPLQHxFvfPS1rr3
         oLxQALyz3GBhbbjkAKUl1DiACSw+7vNQ5cv6LCAUoJBpJmcEUT4QegjfhvmUnqfmT0zZ
         dnd8Vi9KnNJzrXDknT0MXNQoRmL8OpLL6K2bMXhBTVnSvzLfE8YQZwTDnYIMs3Ing9n9
         7JZg==
X-Gm-Message-State: ANoB5pmyfJYKIcHDzxCRSr6Rh+bR8b5t96+arUaLPHPs48qduzXJVeIj
        1X+FSFgACL3GrtrZvcM+l8fgCTqqXxWVBSHxZGi8ZsYKEiIirfhM2VLxdaM80C08vXCRuJ3vA4T
        xpamh64kTvm3HneXvsicr
X-Received: by 2002:a5e:d903:0:b0:6de:d90e:ee05 with SMTP id n3-20020a5ed903000000b006ded90eee05mr10135419iop.2.1670942182513;
        Tue, 13 Dec 2022 06:36:22 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5mLwxzWPfSBfxmcsXPVziNTpTyuENiy9aAV9FJntRMZ3j2oQKc8i8SHP3epsMHh0EojGMExA==
X-Received: by 2002:a5e:d903:0:b0:6de:d90e:ee05 with SMTP id n3-20020a5ed903000000b006ded90eee05mr10135404iop.2.1670942182262;
        Tue, 13 Dec 2022 06:36:22 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id y18-20020a027312000000b003760a908bfasm875133jab.169.2022.12.13.06.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 06:36:21 -0800 (PST)
Date:   Tue, 13 Dec 2022 09:36:19 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.com, linux-spi@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sc8280xp: add missing spi nodes
Message-ID: <Y5iN48rA899u1++7@x1>
References: <20221212182314.1902632-1-bmasney@redhat.com>
 <20221212182314.1902632-5-bmasney@redhat.com>
 <c1c7b1eb-08e7-2ba5-d89a-e0be8f76fd69@quicinc.com>
 <Y5hvlX35nr8xQKEd@x1>
 <77c29d8c-34b3-f508-26bf-22520ccc1f2a@linaro.org>
 <13238048-f07c-3e8d-f170-5330ce94767c@redhat.com>
MIME-Version: 1.0
In-Reply-To: <13238048-f07c-3e8d-f170-5330ce94767c@redhat.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Dec 13, 2022 at 02:08:47PM +0100, Javier Martinez Canillas wrote:
> On 12/13/22 14:02, Krzysztof Kozlowski wrote:
> > On 13/12/2022 13:27, Brian Masney wrote:
> > qcom,spi-video-codec is still not specific enough. You need to describe
> > real device behind spidev. To be clear - you do not describe userspace,
> > but the device.
> > 
> 
> Agree.
> 
> I believe Brian just used "qcom,spi-video-codec" as an example but is only
> a make up name to illustrate the concept. QC needs to determine what would
> be the correct <vendor,device> tuple for the IP block that the user-space
> driver will drive.

Yes, that was just an example.

Shazad: Is this thread clear about what QC needs for spidev? I'll let QC
take care of sending patch(es) to add the various compatibles since I'm
not sure what hardware will be backed by spidev.

I'll take care of making sure that sc8280xp.dtsi gets the spi controller
nodes added.

Brian

