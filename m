Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5B7457482
	for <lists+linux-spi@lfdr.de>; Fri, 19 Nov 2021 17:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbhKSQ6s (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 19 Nov 2021 11:58:48 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:44788 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236404AbhKSQ6s (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 19 Nov 2021 11:58:48 -0500
Received: by mail-oi1-f182.google.com with SMTP id be32so22849545oib.11;
        Fri, 19 Nov 2021 08:55:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yZH3IuJ/71uU9AY771WfZvqzCQriz/vWX4edhDHRAjg=;
        b=Ft/WeeehGhDj4q33ZLFO5c38herF2NCQglPBe+/UuOOHwn4aoR2BBEo2wgWCa5vin3
         bUlIjV5TKrMtEVE5civ0lV6XyZ3GZsErg30jJaZs0LrtJiTZOHJ5RDUHqrhPEgyOjINT
         Fan59hdmeOI0Qb6g9pM9NVmz7O3xA53gvetOMeGMvljYqkXGfQqtA/Jylq0XPnZPXlm+
         cYN7jBo1snz5jkvDy+3q041byWV2NN8Vc+D8kII4ZwzXyLqZP94JwNJLwCI6kPVOrfsw
         Sqh236vjKxM6Epipy7drGp1KmNpKdHlaihBA/MT0eYouVd/uDdYuaTuFc1JAt+15ZAY6
         YGrQ==
X-Gm-Message-State: AOAM530StIVziRxPqPWZxyke+TM+GPPLX+Mns1IwoDlFJ3AJPzJp1R0H
        mWcQcszYLRnCqSwaGQrtElOTWJJEAQ==
X-Google-Smtp-Source: ABdhPJyspmmSPD1psc7BzaZhZbB1K9IHwiyzjHoQfu/YcsS/e/L0vfd/GVFP4RJIc6R+KZjyUfw6Lw==
X-Received: by 2002:aca:120f:: with SMTP id 15mr1063129ois.132.1637340946266;
        Fri, 19 Nov 2021 08:55:46 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f32sm70187otf.35.2021.11.19.08.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 08:55:45 -0800 (PST)
Received: (nullmailer pid 4048629 invoked by uid 1000);
        Fri, 19 Nov 2021 16:55:44 -0000
Date:   Fri, 19 Nov 2021 10:55:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     nandhini.srikandan@intel.com
Cc:     linux-spi@vger.kernel.org, furong.zhou@intel.com,
        broonie@kernel.org, robh+dt@kernel.org, mahesh.r.vaidya@intel.com,
        mallikarjunappa.sangannavar@intel.com, fancer.lancer@gmail.com,
        linux-kernel@vger.kernel.org, kris.pan@intel.com,
        devicetree@vger.kernel.org, mgross@linux.intel.com,
        rashmi.a@intel.com, kenchappa.demakkanavar@intel.com
Subject: Re: [PATCH v3 4/5] dt-bindings: spi: Add bindings for Intel Thunder
 Bay SoC
Message-ID: <YZfXEBLqrYY+0269@robh.at.kernel.org>
References: <20211111065201.10249-1-nandhini.srikandan@intel.com>
 <20211111065201.10249-5-nandhini.srikandan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111065201.10249-5-nandhini.srikandan@intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 11 Nov 2021 14:52:00 +0800, nandhini.srikandan@intel.com wrote:
> From: Nandhini Srikandan <nandhini.srikandan@intel.com>
> 
> Add documentation for SPI controller in Intel Thunder Bay SoC.
> 
> Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
> ---
>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
