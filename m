Return-Path: <linux-spi+bounces-9201-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A1FB14B9E
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jul 2025 11:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53E30189CD13
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jul 2025 09:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA3D27F16C;
	Tue, 29 Jul 2025 09:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="zCS5vVEK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE9A1624E1
	for <linux-spi@vger.kernel.org>; Tue, 29 Jul 2025 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753782670; cv=none; b=mRiITb/VbF6SVccQSYcXufiLY5SnTmQ9txjir71GBCEWk0fuWDgJEI0aRJ6ctM75jUSNo5+2Q1TmmaxgOtZsUuhCi5saQopDi162JxenJi/8gIqrVC61wOEWWDxoP4wQAlPcyKlkX72zaqBatfOWmqQyG03Skfebd8Uaq57CJI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753782670; c=relaxed/simple;
	bh=bscZU/fAojV3otALTAjyNRglp1zsQYrb5IJJWJ4RfUg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cO0Q1W8SvrGISQatIwSVac7ZIvXD5oLGILsqJd2BpHNCvZ/167oJUGXDZVfLiQ2sGi4UqR1d1WJvBJHWthLkmIsbQWV15ndgCViYfd65ks41/lZthWeCOGsGwbpwfMu668sx3CpoWlQWuGdKHhK0SxAV8laXiGYUB4jt3jNA0No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=zCS5vVEK; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7494999de5cso3700740b3a.3
        for <linux-spi@vger.kernel.org>; Tue, 29 Jul 2025 02:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1753782668; x=1754387468; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OJilkARpavILVy56HLGnVjmWO6zPPamZXSDOYdcXO+8=;
        b=zCS5vVEKYaJKG+XG9RKZ5vaM3BebtU4dd+pXEeabI6FXfQm2qPMx+B/YOrADxSh+WX
         9LKRWQvB9erO0QyzFtxE6nhOOWiQ8TBdF+2lNbxvutbYFW5O8Ok5S2ZSRA9ai6JH+T0P
         XYawmB6HFTVVKLxaUEZZGMI8JwL0T+EJODudgIrQ6ePjnJ+ZX/tFPUjMDeVSqrMPq467
         nNhEAtrUbb+UYWqQSPwSd6BD+Ax2mZGdNOqHpB6+V0AT1y+sJYqbaqZH/Xb/inoMAM0O
         tXKKOFsyPXkQQMyqDSFnjpwm9aJLwmsr342r/xaY80AD4XHOGZ/N4oar3qqbplKyF3RZ
         4vgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753782668; x=1754387468;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJilkARpavILVy56HLGnVjmWO6zPPamZXSDOYdcXO+8=;
        b=GeR8md9Q/3S4BkhfzPQkOQPO2Wnzn2iF5nZaZxCM8xET48j8BZSSNNeSwZFmqpahDd
         YZilLL2EgShvbmsVuGkJV805EIgPZCcW3es3krDgNYL5NGA0Vg1UmeuWq3WCuALUmBAh
         4jIH6G4DfUnLwBrQqdRsyxHGbn6fKTqD+NHk3BwBtHji84Q+wrFAEQkwkibFXsaI8MCd
         daneRS7mPKQGnxeIlnifprLfWaGw1flRF1fqtbCNjQipeizEbLsM5xBZywVzgF/B2Wnc
         qZHvpUQk1hMOOjnCOLGevZkg4mLm8lKNuE53jA96/zMOdu3RW6Q5sL2pHmcqv6LG9I+a
         TDAw==
X-Gm-Message-State: AOJu0Yz5G9NspWAfn6085mMBrK9cMn1ehwmopZLTdpy1vQVguEc9e4Rn
	+jtwQguX8G/PWz2L1ZevGh+xlLlIT0aszNbPnVnp9lJvKVdffgT/AU/pSD7Jzygddw==
X-Gm-Gg: ASbGncu/Bc/NPbjtJDyNuemS9EyzROkCSQ6JLT1RhHui/ngcS3sk/+S1iTIkdF0e2uL
	4QPuQnACfllJvB5usYDCMAZbAHDUfftd5GlLGZQRqsJDTIY+0tDyyKpsN1UKPy0m46avt4HnWxw
	UvrKmaNR5M3vqDtmNxjIma3bzSdtKfU1qXIUeVrtJlnZtHKJhIYP6ITqTyPWGKVmlESanFIqjPn
	n1x206UoawjsedE6GopvnQ5HKV8Oqvi0VT/IeAG1d/iXwhfDJst+rtUdcC1ZFBKkCt099QkN4ZF
	4TCEtqMnPpRagzPNC8L+6JtAtFUp4XQzTYqYBYDsLF9c02qriAuZbcXTprsEYjpvqcONliuGrLV
	IDnlA/wnBozfGOeF/g1jLhooxNUBqW/k=
X-Google-Smtp-Source: AGHT+IHqmq0IFMxN9E9dmBi+7kmJSjma8zqXFu8gjlH+mAe2VbvRya+B7bTjCTYKlGfW0smHPiZlQw==
X-Received: by 2002:a05:6a00:3e14:b0:746:298e:4ed0 with SMTP id d2e1a72fcca58-763386be27cmr18993582b3a.13.1753782668097;
        Tue, 29 Jul 2025 02:51:08 -0700 (PDT)
Received: from [192.168.1.6] ([2401:4900:8899:25fe:4fe5:6353:8b2b:942c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b4c8762sm7614498b3a.117.2025.07.29.02.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 02:51:07 -0700 (PDT)
From: Ayush Singh <ayush@beagleboard.org>
Subject: [PATCH 0/4] spi: Introduce spi bus extensions
Date: Tue, 29 Jul 2025 15:20:59 +0530
Message-Id: <20250729-spi-bus-extension-v1-0-b20c73f2161a@beagleboard.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIOZiGgC/x2MQQ5AMBAAvyJ7tklbpPiKOKCLvZR0kSbi78pxk
 pm5QSgwCbTZDYEuFt58Ap1nMK2DXwjZJQajTKWsqVF2xvEUpHiQ/2zURjuqXFOMpYXU7YFmjv+
 z65/nBR4547BjAAAA
X-Change-ID: 20250728-spi-bus-extension-121de5d93b47
To: Mark Brown <broonie@kernel.org>, herve.codina@bootlin.com, 
 luca.ceresoli@bootlin.com, conor+dt@kernel.org, 
 Jason Kridner <jkridner@beagleboard.org>, 
 Deepak Khatri <lorforlinux@beagleboard.org>, Dhruva Gole <d-gole@ti.com>, 
 Robert Nelson <robertcnelson@beagleboard.org>, Andrew Davis <afd@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Ayush Singh <ayush@beagleboard.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6832; i=ayush@beagleboard.org;
 h=from:subject:message-id; bh=bscZU/fAojV3otALTAjyNRglp1zsQYrb5IJJWJ4RfUg=;
 b=owEBbQKS/ZANAwAKAQXO9ceJ5Vp0AcsmYgBoiJmGcZmpM6seD6EGpK0iSnVa/Hc3ZS2G9oyai
 bQMmHEATLuJAjMEAAEKAB0WIQTfzBMe8k8tZW+lBNYFzvXHieVadAUCaIiZhgAKCRAFzvXHieVa
 dImTD/9Hm8GSKA9gY+lqe3hkg0UW9KDCC8lL6cWVbbXKJXR3xqUlMrhQ5s32OKK8Vy0ogxhWJ2C
 Zu1MwbepKRDRl5779uKgGfSiS4npBmZLsKvqHbq5xCClpyl2LyEIdNN5r772tHpKGcJSNla/a+2
 tdafBbkWqZdADtIo8NEkZz9aui5/fMteSPxkjf/tYbQlw3YgvydzUbiyYKRX8OxY7+e//WMqN4s
 8wTI3fIBNgzF/v06ToYNgeDhRvNM8iivSsugjVxXxeBoASwXwXlQ5UKq4hINWVwI1EEm8/yDDj6
 IIWn+ZQgT86r/3qrMPtMr5K3tnzFgYCzphMPvQ5PwmxF/dgZaQxD8onpPhc7vM7AwCuUTbJuf2D
 Bs7FVGFUjn+E7jbGFvDfCeMtjf1SoqPvSPGQpbli2HGKZGGwuCU3XDImuqEAm3yr/+aGztMtSNQ
 DAUnUfK6tSBDp6M3AxVlDxemsVAb/lI88IYtWcb2JuqMMfzqB6xv8VLXUxhFf1pKsMFN7nLOt7y
 ya2xf/vkIalfBsmGsOMYnAWgAQ3IC2zxV47FU61Sp+TemWEMJtmohWeOgNmGp9FCerfWE+m2n1F
 0ty1y1zsthDO4Z1tQ0upiwJSd0R8WF0UCk0//tFetn1xxwHgzdlJk3bNbExblQev1w0eM+5//ZZ
 06VhGkJPyF3hWfQ==
X-Developer-Key: i=ayush@beagleboard.org; a=openpgp;
 fpr=DFCC131EF24F2D656FA504D605CEF5C789E55A74

This patch series is basically an SPI version of i2c-bus-extension patch
series [0].

The big picture behind this RFC series is to support a Linux device
with a connector to physically add and remove an add-on to/from the
main device to augment its features at runtime, adding devices on
non-discoverable busses, using device tree overlays.

The related big picture has been already presented in
  - the 'Add support for GE SUNH hot-pluggable connector' series [0]
  - the 'Runtime hotplug on non-discoverable busses with device tree
    overlays' talk at Linux Plumbers Conference 2024 [1].

This series focuses on the SPI related part.

An spi bus is wired to the connector and allows an add-on board to
connect additional spi devices to this bus.

When device tree nodes are added, the SPI core tries to probe client
devices based on the classic DT structure:

  spi@abcd0000 {
      some-client@42 { compatible = "xyz,blah"; ... };
  };

However for hotplug connectors described via device tree overlays [1]
there is additional level of indirection, which is needed to decouple
the overlay and the base tree:

  --- base device tree ---

  spi1: spi@abcd0000 {
      compatible = "xyz,spi-ctrl";
      spi-bus-extension@0 {
          spi-bus = <&spi_ctrl>;
      };
      ...
  };

  spi5: spi@cafe0000 {
      compatible = "xyz,spi-ctrl";
      spi-bus-extension@0 {
          spi-bus = <&spi-sensors>;
      };
      ...
  };

  connector {
      spi_ctrl: spi-ctrl {
          spi-parent = <&spi1>;
          #address-cells = <1>;
          #size-cells = <0>;
      };

      spi-sensors {
          spi-parent = <&spi5>;
          #address-cells = <1>;
          #size-cells = <0>;
      };
  };

  --- device tree overlay ---

  ...
  // This node will overlay on the spi-ctrl node of the base tree
  spi-ctrl {
      device@1 { compatible = "xyz,foo"; ... };
  };
  ...

  --- resulting device tree ---

  spi1: spi@abcd0000 {
      compatible = "xyz,spi-ctrl";
      spi-bus-extension@0 {
          spi-bus = <&spi_ctrl>;
      };
      ...
  };

  spi5: spi@cafe0000 {
      compatible = "xyz,spi-ctrl";
      spi-bus-extension@0 {
          spi-bus = <&spi-sensors>;
      };
      ...
  };

  connector {
      spi-ctrl {
          spi-parent = <&spi1>;
          #address-cells = <1>;
          #size-cells = <0>;

          device@1 { compatible = "xyz,foo"; ... };
      };

      spi-sensors {
          spi-parent = <&spi5>;
          #address-cells = <1>;
          #size-cells = <0>;
      };
  };

Here spi-ctrl (same goes for spi-sensors) represent the part of SPI bus
that is on the hot-pluggable add-on. On hot-plugging it will physically
connect to the SPI adapter on the base board. Let's call the 'spi-ctrl'
node an "extension node".

In order to decouple the overlay from the base tree, the SPI adapter
(spi@abcd0000) and the extension node (spi-ctrl) are separate nodes.
Rightfully, only the former will probe into an SPI adapter, and it will
do that perhaps during boot, long before overlay insertion or after the
overlay has been inserted for instance if the SPI adapter is remove and
re-probed for whatever reason after the overlay insertion.

The extension node won't probe into an SPI adapter or any other device
or bus, so its subnodes ('device@1') won't be interpreted as SPI
clients by current SPI core code.

The extension node is linked to the adapter node in two ways. The first
one with the spi-bus-extension adapter sub-node and the second one with
the spi-parent property in the extension node itself.

The purpose of those two links is to handle device probing in several
cases.

- First case: Adapter already probed when add-on devices are added

When devices are added by the overlay, an OF change notification is
triggered so that busses can support those new devices.

Going from a newly added device node, the spi-parent property allows to
find the corresponding SPI adapter and register the new SPI client with
this adapter.

The patch 1 in this series proposes modification to handle this case
and, by the nature of the modification, all cases where a phandle refers
an extension node instead of the adapter node itself.

- Second case: Add-on devices already present in device-tree when
  adapter is probed

In this case, everything is already described in the device-tree and
then the adapter is probed.

OF change notifications don't play a role in this case either because
they were never triggered (the overlay was applied by the bootloader)
or they were triggered before the adapter is probed and so were
missed/ignored.

The adapter probe process registers device already described at the
adapter node level (current code) and, thanks to spi-bus-extension
adapter sub-node and its spi-bus property, it can also follow the
extension and registers devices described in those extension nodes.

The patch 2 and 3 in this series proposes modifications to handle this
case.

The patch 4 provides the device-tree bindings for spi-bus-extension and
spi-parent.

I also have a prototype driver with addon-board overlays to see how
combining all the relevant patches looks for support Beagle capes for
PocketBeagle 2 [3]. The tree can be found here [4]. To be more specific,
the base board overlay can be found here [5] and the addon board
(Techlab Cape [6]) overlay can be found here [7].

Best Regards,
Ayush Singh

[0]: https://lore.kernel.org/all/20250205173918.600037-1-herve.codina@bootlin.com/
[1]: https://lore.kernel.org/all/20240917-hotplug-drm-bridge-v4-0-bc4dfee61be6@bootlin.com/
[2]: https://lpc.events/event/18/contributions/1696/
[3]: https://www.beagleboard.org/boards/pocketbeagle-2
[4]: https://github.com/Ayush1325/linux/commits/beagle-cape-v1/
[5]: https://github.com/Ayush1325/BeagleBoard-DeviceTrees/commit/0d919e3fca9bc134b8593db16d1da9d73bdb794f
[6]: https://www.beagleboard.org/boards/techlab
[7]: https://github.com/Ayush1325/linux/commit/7a6728e35b4b82e94c24a0a9464ab849b8485812

Signed-off-by: Ayush Singh <ayush@beagleboard.org>
---
Ayush Singh (4):
      spi: Follow spi-parent when retrieving a controller from node
      spi: Move children registration in a dedicated function
      spi: Handle spi bus extension
      devicetree: bindings: spi: Introduce SPI bus extensions

 .../devicetree/bindings/spi/spi-controller.yaml    | 66 +++++++++++++++++++++-
 drivers/spi/spi.c                                  | 63 +++++++++++++++++----
 2 files changed, 116 insertions(+), 13 deletions(-)
---
base-commit: d7af19298454ed155f5cf67201a70f5cf836c842
change-id: 20250728-spi-bus-extension-121de5d93b47

Best regards,
-- 
Ayush Singh <ayush@beagleboard.org>


