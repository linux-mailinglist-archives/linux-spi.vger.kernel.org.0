Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BECE5414DE1
	for <lists+linux-spi@lfdr.de>; Wed, 22 Sep 2021 18:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbhIVQQF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Sep 2021 12:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236590AbhIVQQF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Sep 2021 12:16:05 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A72C061574
        for <linux-spi@vger.kernel.org>; Wed, 22 Sep 2021 09:14:35 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s11so3161442pgr.11
        for <linux-spi@vger.kernel.org>; Wed, 22 Sep 2021 09:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=FIy+lueEhEFu9UJa3Z08pj8ciR0pic4lgORGM9ej1k8=;
        b=T0tt5zDfWHFG5QEBa9ciYnC6F/u3xAQypKgYl0vULkTNIhRf2R1jvtzzJwlpR1/024
         Utrq6m/qRz38ZVUn3WInpKKgsZZ4MSDpmGh07LPtotH6cSGJxA1UCoLuWnG63Pd2bLeo
         U/FT51LCvW5PxWwddyIIyAQzxgQGJh6pzw/mE05wLZXyncCE8gD0yGfgB+wjBFdbBMJT
         LQa1vfZ1JaYUEKp0uai1KgRappItUDWSmY2zm6pQ7b0Le5hCh5uBgCay7p6h0N9BryJ6
         4z6Fvscg/KH8SsU2Jd1IX6EA/uRQybtMfrDCL7oEGe+q6FZsdyc23PHgTNuuIQHkbj/U
         MMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FIy+lueEhEFu9UJa3Z08pj8ciR0pic4lgORGM9ej1k8=;
        b=zEpKmh91KJzQHeTDNBHknaF0IjbFoYSzv6GLsaqQoUb3PHWqvwyd8BtCXp2Vw5T0ac
         qOLReHMJlpY01MWiCedN+Oc4G/oM16h7aD5RJjlXoxWI9P3N9iVpfj58U7cA9eSaueVY
         asP267kSw50/uITcmNAZ6co6anzKyseNH573cij4M4adaP/R7H3VAh1GwdkQdnxM/ddN
         H8LgkW/OuZcX9isi3SsLkkMyugqXUaEBpJpz9QZxUdiBZOldZelNx8Qd6yOQV7A0Uy1u
         uy3xLBEG9H4E+jyYQm22AJxyMULKBViY5IgjvrwmGMMPVwuO88/THAJeUPIVbjByJFdJ
         Y4fg==
X-Gm-Message-State: AOAM531FOo/tx623sxigwIt3N0ATg7RaMysDZYMQgZZc6DVhnTB4PwgH
        FYs9U35S+grskRW/NnoiWYM3+SJX5zhbNbc7L8jdxvOZcj4=
X-Google-Smtp-Source: ABdhPJy8Fo2pYixMGZCFFVlhIvmPJv8qf2uY9IlW8v0hhRLsqGaT/sPxBedPiCi0KPLcUELttXMzEdT52ZSZ2BmkkIw=
X-Received: by 2002:a63:cf41:: with SMTP id b1mr393032pgj.407.1632327274429;
 Wed, 22 Sep 2021 09:14:34 -0700 (PDT)
MIME-Version: 1.0
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 22 Sep 2021 09:14:23 -0700
Message-ID: <CAJ+vNU2aTKyQ=UwJMLKf9D7CTk4F59o3uHCC80jJBOge-Ff9Aw@mail.gmail.com>
Subject: spi-thunderx (OcteonTX) max SPI frequency
To:     linux-spi@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Jan Glauber <jglauber@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Greetings,

Does anyone know why the MAX spi frequency for the spi-thunderx driver
would be 16MHz? The CN81XX HM states the SPI clock frequency can go up
to 50MHz.

The driver was originally for Octeon (I'm thinking this was CN7xxx
SoC's?) which perhaps were limited to 16MHz yet I downloaded a CN70XX
ref manual and it shows 25MHz.

I don't know my history regarding the Cavium (now Marvell) SoC's well
enough to know exactly what Octeon means or meant vs ThunderX. Hoping
someone from Marvell can answer this.

Best regards,

Tim
